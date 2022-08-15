math.randomseed(tick())

--print("starting script...")

local roundStatus = game.ReplicatedStorage.RoundStatus
local powerUps = game.ReplicatedStorage.Assets.powerUps
local powerupTokens = game.ReplicatedStorage.Assets.PowerupTokens
local coinRainEvent = game.ReplicatedStorage.Events.CoinRainEvent
local height = 400
local extendedRadius = 5
local isCoinRain = false
local avgFruitsPerPlayer = 50

local function chooseSize()
	local randNum = math.random(100)
	local size
	if randNum < 45 then -- 0 = 50%
		size = 1
	elseif randNum < 65 then -- 1 = 40%
		size = 1.5
	elseif randNum < 83 then -- 2 = 3%
		size = 2
	elseif randNum < 87 then -- 2 = 3%
		size = 2.5
	elseif randNum < 90 then
		size = 3
	else  -- 2%
		size = -1
	end
	--print("chosen!".. selected)
	return size
end

-- Indexes: 1 = Fruit | 2 = Wood | 3 = Stone | 4 = Gold | 5 = Ruby | 6 = Diamond
local function chooseCoin()
	local randNum = math.random(100)
	local index
	if randNum < 60 then -- Fruit = 60%
		index = 1
	elseif randNum < 80 then -- Wood = 20%
		index = 2
	elseif randNum < 90 then -- Stone = 10%
		index = 3
	elseif randNum < 96 then -- Gold = 6%
		index = 4
	elseif randNum < 99 then -- Ruby = 3%
		index = 5
	else  -- Diamond = 1%
		index = 6
	end
	
	return index
end

local indexToCoin = {
	[2] = "Wood Token",
	[3] = "Stone Token",
	[4] = "Gold Token",
	[5] = "Ruby Token",
	[6] = "Diamond Token"
}

local function checkCollision(p, r, rect)
	local closestX = math.clamp(p.X, rect.Position.X - 0.5 * rect.Size.X, rect.Position.X + 0.5 * rect.Size.X)
	local closestZ = math.clamp(p.Y, rect.Position.Z - 0.5 * rect.Size.Z, rect.Position.Z + 0.5 * rect.Size.Z) -- Z pos == Y in (X, Y) format
	local distanceX = p.X - closestX
	local distanceZ = p.Y - closestZ -- Z pos == Y in (X, Y) format
	local distSquared = distanceX * distanceX + distanceZ * distanceZ
	return distSquared < r * r
end

local selectedX, selectedZ

local total
local spawnPart

function calculateXZ(selectedAreas)
	-- Find part to place on
	local rand = math.random(0, total)
	for i, part in pairs(selectedAreas) do
		rand -= part.Size.X * part.Size.Z
		if rand <= 0 then
			spawnPart = part
			break
		end
	end
	-- Calc point
	local sX = math.random(spawnPart.Position.X - spawnPart.Size.X / 2, spawnPart.Position.X + spawnPart.Size.X / 2)
	local sZ = math.random(spawnPart.Position.Z - spawnPart.Size.Z / 2, spawnPart.Position.Z + spawnPart.Size.Z / 2)
	return sX, sZ
end

print(roundStatus.inRound.Value)
roundStatus.inRound.Changed:Connect(function()
	-- Add map areas to the d
	if roundStatus.inRound.Value == true then
		wait(8)
		height = workspace.Map.BaseParts.BasePart.Position.Y + 80
		--print("inround changed")
		while roundStatus.inRound.Value do
			wait()
			total = 0
			local centerX = 0
			local centerZ = 0
			local spawnedPlayers = {}
			
			for i,v in pairs(game.Players:GetPlayers()) do
				local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(v.Name)
				if playerFolder then
					if playerFolder.playerStats.isSpawned.Value then
						centerX = centerX + v.Character.HumanoidRootPart.Position.X
						centerZ = centerZ + v.Character.HumanoidRootPart.Position.Z
						table.insert(spawnedPlayers, v.Character)
					end
				end
			end
			
			centerX = centerX / #spawnedPlayers
			centerZ = centerZ / #spawnedPlayers
			--print("while inround is true...")
			
			local maxRadius = -1
			local center = Vector2.new(centerX, centerZ)
			
			for i,v in pairs(spawnedPlayers) do
				local XZPos = Vector2.new(v.HumanoidRootPart.Position.X, v.HumanoidRootPart.Position.Z)
				local distance = (center - XZPos).Magnitude
				if distance > maxRadius then
					maxRadius = distance
				end
			end
			
			maxRadius = maxRadius + extendedRadius
			
			local selectedAreas = {}
			
			for i,v in pairs(game.Workspace.Map.BaseParts:GetChildren()) do
				if checkCollision(center, maxRadius, v) then
					table.insert(selectedAreas, v)
					total += v.Size.Z * v.Size.X
				end
			end
			
			if #selectedAreas > 0 then
				selectedX, selectedZ = calculateXZ(selectedAreas)
				local waitInterval = game.ReplicatedStorage.GameParams.RoundLength.Value / (avgFruitsPerPlayer * #spawnedPlayers)
				if isCoinRain then
					waitInterval = waitInterval / 1.666666
				end
				wait(waitInterval)
				local selectedSize = chooseSize()
				local selectedItem
				local chosen
				if isCoinRain then
					chosen = chooseCoin()
					if chosen == 1 then
						selectedItem = powerUps:GetChildren()[math.random(#powerUps:GetChildren())]
					else
						selectedItem = powerupTokens[indexToCoin[chosen]]
					end
				else
					if selectedSize == -1 then
						selectedItem = game.ReplicatedStorage.Assets.SpecialPowerUps.Health
					else
						selectedItem = powerUps:GetChildren()[math.random(#powerUps:GetChildren())]
					end
				end
				local clonedItem = selectedItem:Clone()
				if chosen == 1 or not isCoinRain then
					if selectedSize ~= -1 then
						clonedItem.Size = Vector3.new(clonedItem.Size.X * selectedSize, clonedItem.Size.Y * selectedSize, clonedItem.Size.Z * selectedSize)
						clonedItem.evoLvl.Value = selectedSize
					end
				end
				clonedItem.Parent = workspace.Powerups
				
				if clonedItem:IsA("Model") then
					clonedItem:SetPrimaryPartCFrame(CFrame.new(selectedX, height, selectedZ) * CFrame.Angles(math.rad(math.random(1, 90)), math.rad(math.random(1, 90)), math.rad(math.random(1, 90))))
				else
					clonedItem.CFrame = CFrame.new(selectedX, height, selectedZ) * CFrame.Angles(math.rad(math.random(1, 90)), math.rad(math.random(1, 90)), math.rad(math.random(1, 90)))

				end
			end
		end
	else
		isCoinRain = false
	end
end)

local function initiateCoinRain()
	isCoinRain = true
end

coinRainEvent.Event:Connect(initiateCoinRain)