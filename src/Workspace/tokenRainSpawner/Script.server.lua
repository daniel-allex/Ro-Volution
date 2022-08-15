-- Indexes: 1 = Stone | 2 = Gold | 3 = Ruby | 4 = Diamond
local function chooseCoin()
	local randNum = math.random(100)
	local index
	if randNum < 10 then -- Stone = 10%
		index = 1
	elseif randNum < 30 then -- Gold = 20%
		index = 2
	elseif randNum < 70 then -- Ruby = 40%
		index = 3
	else  -- Diamond = 30%
		index = 4
	end

	return index
end

local indexToCoin = {
	[1] = "Stone Token",
	[2] = "Gold Token",
	[3] = "Ruby Token",
	[4] = "Diamond Token"
}

local function runCoinRain()
	if game.ReplicatedStorage.RoundStatus.inRound.Value == false then
		while game.ReplicatedStorage.RoundStatus.inRound.Value == false do
			wait(0.1)
			local chosenIndex = chooseCoin()
			local chosenCoin = indexToCoin[chosenIndex]
			local coinSearch = game.ReplicatedStorage.Assets.PowerupTokens:FindFirstChild(chosenCoin)
			if coinSearch then
				local coinCopy = coinSearch:Clone()
				coinCopy.Script:Destroy()
				coinCopy.Sound:Destroy()
				coinCopy.AnimalBux:Destroy()
				coinCopy.CanCollide = false
				local sX = math.random(script.Parent.Position.X - script.Parent.Size.X / 2, script.Parent.Position.X + script.Parent.Size.X / 2)
				local sZ = math.random(script.Parent.Position.Z - script.Parent.Size.Z / 2, script.Parent.Position.Z + script.Parent.Size.Z / 2)
				coinCopy.CFrame = CFrame.new(sX, script.Parent.Position.Y, sZ) * CFrame.Angles(math.rad(math.random(1, 90)), math.rad(math.random(1, 90)), math.rad(math.random(1, 90)))
				coinCopy.Parent = workspace.DecorTokenRain
			end
		end
	end
end

runCoinRain()

game.ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	runCoinRain()
end)