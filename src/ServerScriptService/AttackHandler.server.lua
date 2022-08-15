-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local marketplaceService = game:GetService("MarketplaceService")


local statfile = ReplicatedStorage:WaitForChild("StatFile")

local ownsToMultiplier = {
	[true] = Vector3.new(1, 2, 2),
	[false] = Vector3.new(1, 1, 1)
}

local ownsToColor = {
	[true] = BrickColor.new("New Yeller"),
	[false] = BrickColor.new("Bright red")
}


--local GA = require(153590792)
local category = "Kills and Deaths"
local action = "Death"
local label = "The amount of deaths"
local deathValue = 0

-- Events
local Attack = ReplicatedStorage.Events.Attack
local Stomp = ReplicatedStorage.Events.Stomp

-- Server-side player variables
local playerArray = {}

local function applyKnockback(player, pStats, enemyHumanoid, damage, attackType)
	local playerChar = player.Character
	local playerHRP = playerChar.HumanoidRootPart
	local enemyHRP = enemyHumanoid.Parent.HumanoidRootPart
	local enemyName = enemyHumanoid.Parent.Name
	local enemyFolder = ReplicatedStorage.StatFile:FindFirstChild(enemyName)
	local enemyEvo = 0
	if enemyFolder then
		enemyEvo = enemyFolder.playerStats.evoLvl.Value
	end
	
	local attackTypeToWorth = {
		["Attack"] = 5,
		["Stomp"] = 8
	}
	
	local evoLvl = pStats.playerStats.evoLvl.Value
	-- Get the evoLvls of the player
	---local playerEvo = statfile:FindFirstChild(player.Name).playerStats.
	
	-- BodyVelocity tries to force a constant velocity
	
	local BV = Instance.new("BodyVelocity", enemyHRP) -- create a new BodyVelocity object to apply knockback to target
	BV.MaxForce = Vector3.new(100000, 100000, 100000)
	BV.P = math.huge
	local componentX = 0
	local componentZ = 0
	
	if math.abs((enemyHRP.Position - playerHRP.Position).X) > math.abs((enemyHRP.Position - playerHRP.Position).Z) then
		if (enemyHRP.Position - playerHRP.Position).X > 0 then
			componentX = 1
			componentZ = (1 / (enemyHRP.Position - playerHRP.Position).X)
		else
			componentX = -1
			componentZ = (1 / (enemyHRP.Position - playerHRP.Position).X)
		end
	else
		if (enemyHRP.Position - playerHRP.Position).Z > 0 then
			componentZ = 1
			componentX = (1 / (enemyHRP.Position - playerHRP.Position).Z)
		else
			componentZ = -1
			componentX = (1 / (enemyHRP.Position - playerHRP.Position).Z)
		end

	end
	
	if enemyHumanoid.Health <= (damage - 0.01) then
		local x = componentX * (math.log(1 + math.max(0, (evoLvl - enemyEvo))) + 10) * attackTypeToWorth[attackType]
		local y = 0
		local z = componentZ * (math.log(1 + math.max(0, (evoLvl - enemyEvo))) + 10) * attackTypeToWorth[attackType]
		BV.Velocity = Vector3.new(x, y, z)
	else
		local x = componentX * (math.log(1 + math.max(0, (evoLvl - enemyEvo))) + 10) * attackTypeToWorth[attackType]
		local y = 0
		local z = componentZ * (math.log(1 + math.max(0, (evoLvl - enemyEvo))) + 10) * attackTypeToWorth[attackType]
		BV.Velocity = Vector3.new(x, y, z)
	end
	if attackType == "Attack" then
		Debris:AddItem(BV, 0.1) -- apply BodyVelocity for a short time
	elseif attackType == "Stomp" then
		Debris:AddItem(BV, 0.16) 
	end
	
	--[[	
	if enemyHumanoid.Health <= (dmg + 0.01) then
		BV.Velocity = playerHRP.CFrame.LookVector * 65
	else
		BV.Velocity = playerHRP.CFrame.LookVector * 40
	end
	
	BodyForce relies solely on the force to accelerate
	local bf = Instance.new("BodyForce", enemyHRP)
	bf.Force = playerHRP.CFrame.LookVector * 100
	Debris:AddItem(bf, 0.2)
	]]
end

local function updatePlayerSounds(player, playerSize) 
	local char = player.Character or player.CharacterAdded:Wait()
	if not player and not char then
		return
	end
	
	local playerHRP = char:FindFirstChild("HumanoidRootPart")
	if not playerHRP then
		return
	end
	
	local stompSound = playerHRP.Stomp
	local punchSound = playerHRP.Punch
	
	
	stompSound.RollOffMaxDistance = 40 + playerSize * 2.45
	stompSound.RollOffMinDistance = 20 + playerSize * 2.45
	
	punchSound.RollOffMaxDistance = 40 + playerSize * 2.45
	punchSound.RollOffMinDistance = 20 + playerSize * 2.45
end

-- Deal damage to hit humanoid
local function doDamage(player, pStats, humanoid, damage, attackType)
		if humanoid.Health > damage then
			applyKnockback(player, pStats, humanoid, damage, attackType)
			humanoid.Health -= damage
		local pfolder = game.ReplicatedStorage.StatFile:FindFirstChild(humanoid.Parent.Name)
		if pfolder then
			pfolder.playerStats.lastHit.Value = tick()
		end
			print(player.Name .. " did " .. damage .. " damage to " .. humanoid.Parent.Name)
		else
			deathValue += 1
			print(humanoid.Parent.Name .. " killed by " .. player.Name)
			humanoid.Health = 0
			pStats.statnumbers.Kills.Value += 1
			--GA.Init("UA-172965775-1")
			--GA.ReportEvent(category, action, label, deathValue)

			--local playerFolder = statfile:FindFirstChild(player.Name)
			--playerFolder.playerStats.evoLvl.Value += 1
	end
end

local function createAOEEffect(player, playerSize)
	local char = player.Character
	local LLL = char.LeftLowerLeg
	local ownsGamePass = false
	local success, err = pcall(function()
		ownsGamePass = marketplaceService:UserOwnsGamePassAsync(player.UserId, game.ReplicatedStorage.Assets.Gamepasses.StompRadius.Value)
	end)
	
	if not success then
		warn(err)
	end
	local aoeEffect = Instance.new("Part", LLL)
	aoeEffect.Name = "aoe"
	aoeEffect.Anchored = true
	aoeEffect.CanCollide = false
	aoeEffect.Material = "Neon"
	aoeEffect.Shape = "Cylinder"
	aoeEffect.BrickColor = ownsToColor[ownsGamePass]
	aoeEffect.Size = Vector3.new(1, 0.1, 0.1) * playerSize
	aoeEffect.Position = LLL.Position
	aoeEffect.Orientation += Vector3.new(0, 0, 90)
	
	local tweenInformation = TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
	local propertiesEndGoal = {
		Size = Vector3.new(math.min(1 * playerSize, 20), 12 * playerSize, 12 * playerSize) * ownsToMultiplier[ownsGamePass],
		Transparency = 1
	}
	
	local Tween = TweenService:Create(aoeEffect, tweenInformation, propertiesEndGoal)
	Tween:Play()
	Tween.Completed:Wait()
	aoeEffect:Destroy()
end

game.Players.PlayerAdded:Connect(function(player)

	player.CharacterAppearanceLoaded:Connect(function(char)
		-- Add each player to playerArray
		playerArray[player.Name] = {
			atkLifespan = 0;
			canAttack = true; -- each player gets a server-side basic attack debounce
			playersHitByStomp = {};
			connArray = {}
		}
		
		local punchS = char:FindFirstChild("Punch")
		local stompS = char:FindFirstChild("Stomp")
		if punchS then
			print("Punch sound already exists for " .. player.Name)
		else
			local punchSound = ReplicatedStorage.Assets.Audio.Punch:Clone()
			punchSound.Parent = char.HumanoidRootPart
			print("Punch sound inserted into " .. player.Name .. "'s HRP")
		end

		if stompS then
			print("Stomp sound already exists for " .. player.Name)
		else
			local stompSound = ReplicatedStorage.Assets.Audio.Stomp:Clone()
			stompSound.Parent = char.HumanoidRootPart
			print("Stomp sound inserted into " .. player.Name .. "'s HRP")
		end
		
		local playerFolder = statfile:FindFirstChild(player.Name)
		if playerFolder then
			--local pStats = playerFolder:FindFirstChild("playerStats")
			local connArray = playerArray[player.Name].connArray
			
			if ReplicatedStorage.RoundStatus.inRound.Value then
				updatePlayerSounds(player, playerFolder.playerStats.evoLvl.Value)
			end
			
			table.insert(connArray, playerFolder.playerStats.evoLvl.Changed:Connect(function()
				if ReplicatedStorage.RoundStatus.inRound.Value then
					updatePlayerSounds(player, playerFolder.playerStats.evoLvl.Value)
				end
			end))
			
			table.insert(connArray, ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
				if ReplicatedStorage.RoundStatus.inRound.Value then
					playerArray[player.Name] = {
						atkLifespan = 0;
						canAttack = true; -- each player gets a server-side basic attack debounce
						playersHitByStomp = {};
						connArray = {}
					}
					updatePlayerSounds(player, playerFolder.playerStats.evoLvl.Value)
				end
			end))
			
		end
	end)
end)


game.Players.PlayerRemoving:Connect(function(player)
	-- Disconnect connections tied to RoundStatus.inRound
	for key, value in pairs(playerArray[player.Name].connArray) do
		if value.Connected then
			value:Disconnect()
		end
	end 
	-- Remove data of players who have left
	playerArray[player.Name] = nil
	
end) 

Attack.OnServerEvent:Connect(function(player)
	if player.Character.Humanoid.Health > 0 then 

		--updatePunch(player)
		player.Character.HumanoidRootPart.Punch:Play()
		--statfile:FindFirstChild(player.Name).playerStats.stompLevel.Value += 1 -- testing only
		local playerData = playerArray[player.Name]
		if not playerData["canAttack"] then
			print(player.Name .. " cannot attack")
			return
		end
		
		-- Set attack-related variables
		local playerHumanoid = player.Character:WaitForChild("Humanoid")
		playerData["canAttack"] = false
		playerData["atkLifespan"] = 0.4	-- How long the connection should last
		
		-- Create a connection that fires when the player touches another part
		local connection
		connection = playerHumanoid.Touched:Connect(function(hitPart, playerLimb)
			if (playerData["atkLifespan"] <= 0 and connection.Connected == true) then
				connection:Disconnect()
				playerData["canAttack"] = true
				print("Connection disconnected via timeout. (Attack Lifespan)")
				return
			end
			local enemyHumanoid
			if hitPart.Parent:FindFirstChild("Humanoid") then
				enemyHumanoid = hitPart.Parent:FindFirstChild("Humanoid")
			elseif hitPart.Parent.Parent:FindFirstChild("Humanoid") then
				enemyHumanoid = hitPart.Parent.Parent:FindFirstChild("Humanoid")
			end
			
			if enemyHumanoid == playerHumanoid then
				connection:Disconnect()
				playerData["canAttack"] = true
				print("Connection disconnected via timeout. (Attack Lifespan)")
				return
			end
			
			-- Some part of this might be preventing punching from killing players; test later, still not sure
			if playerData["atkLifespan"] > 0 and enemyHumanoid and (playerLimb.Name == "LeftFoot" or playerLimb.Name == "LeftHand" or playerLimb.Name == "LeftLowerArm" or playerLimb.Name == "LeftLowerLeg" or playerLimb.Name == "LeftUpperArm" or playerLimb.Name == "LeftUpperLeg" or playerLimb.Name == "RightFoot" or playerLimb.Name == "RightHand" or playerLimb.Name == "RightLowerArm" or playerLimb.Name == "RightLowerLeg" or playerLimb.Name == "RightUpperArm" or playerLimb.Name == "RightUpperLeg") then
				local pStats = statfile:FindFirstChild(player.Name)
				local evoLvl = pStats.playerStats.evoLvl.Value
				
				--Do damage to other player
				local dmg = math.floor(10 + evoLvl ^ (21/34))
				doDamage(player, pStats, enemyHumanoid, dmg, "Attack")
				connection:Disconnect()
				playerData["canAttack"] = true
				statfile:FindFirstChild(player.Name).playerStats.stompLevel.Value += 1
				
				
				print("Connection disconnected via hit.")
				
			end
		end)
	end
end)

Stomp.OnServerEvent:Connect(function(player)
	local pStatfile = statfile:FindFirstChild(player.Name)
	local pStats = pStatfile.playerStats
	if pStats.stompLevel.Value < 15 then
		print("Not enough stompLevel: " .. pStats.stompLevel.Value)
		return
	else
		print("Enough stompLevel")
		pStats.stompLevel.Value = 0
	end

	local playerData = playerArray[player.Name]
	local char = player.Character
	
	-- Create the visual effect for the stomp
	local playerSize = char.Humanoid.BodyWidthScale.Value
	
	
	-- Create an explosion to check who was in range of the stomp
	local ownsGamePass = false
	local success, err = pcall(function()
		ownsGamePass = marketplaceService:UserOwnsGamePassAsync(player.UserId, game.ReplicatedStorage.Assets.Gamepasses.StompRadius.Value)
	end)

	if not success then
		warn(err)
	end
	local stompRangeValue = 6 * playerSize
	if ownsGamePass then
		stompRangeValue = stompRangeValue * 2
	end
	local stompAOE = Instance.new("Explosion")
	stompAOE.DestroyJointRadiusPercent = 0
	stompAOE.BlastRadius = stompRangeValue
	stompAOE.BlastPressure = 0
	stompAOE.ExplosionType = Enum.ExplosionType.NoCraters
	stompAOE.Position = player.Character.HumanoidRootPart.Position
	stompAOE.Visible = false
	
	local playersHit = playerData["playersHitByStomp"]
	playerData["playersHitByStomp"] = {}
	
	stompAOE.Hit:Connect(function(part, distance)
		local parent = part.Parent
		--print("1 " .. part.Name)
		--print(parent.Name)
		--print(parent.Parent.Name)
		if parent then
			if playersHit[parent] then -- check if player has already been hit
				return
			end
			
			playersHit[parent] = true
			
			if parent.Parent then
				playersHit[parent.Parent] = true
			end
			--print(parent.Name .. " hit by stomp from " .. player.Name)
			local humanoid = parent:FindFirstChild("Humanoid") or parent.Parent:FindFirstChild("Humanoid")
			if humanoid and humanoid ~= char.Humanoid then
				-- do damage here
				local evoLvl = pStats.evoLvl.Value
				local dmg = math.floor(10 + 1.5 * evoLvl ^ (21/34))
				doDamage(player, pStatfile, humanoid, dmg, "Stomp")
			end	
		end
	end)
	
	stompAOE.Parent = game.Workspace
	--updateStomp(player)
	player.Character.HumanoidRootPart.Stomp:Play()
	createAOEEffect(player, playerSize)
end)


RunService.Heartbeat:Connect(function(step)
	for _, player in pairs(playerArray) do
		if player["atkLifespan"] > 0 then
			player["atkLifespan"] -= step -- decrement lifespan of each player's attack (whether it exists or not)
		end
	end
end)