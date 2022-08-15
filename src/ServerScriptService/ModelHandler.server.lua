local replicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local changeSize = replicatedStorage.Events.changeSize
local evoLevelTEMP = 0
local statfile = replicatedStorage:WaitForChild("StatFile")
local lines = replicatedStorage.EvolutionLines

local THRESHOLD_ONE = replicatedStorage.GameParams.Threshold1.Value
local THRESHOLD_TWO = replicatedStorage.GameParams.Threshold2.Value

local SpeedPerEvolvl = replicatedStorage.GameParams.SpeedPerEvolvl
local HealthPerEvolvl = replicatedStorage.GameParams.HealthPerEvolvl
local JumpLossPerEvolvl = replicatedStorage.GameParams.JumpLossPerEvolvl
local SizePerEvolvl = replicatedStorage.GameParams.SizePerEvolvl

local inRound = replicatedStorage.RoundStatus.inRound
local changeStarted = replicatedStorage.Events.changeStarted
local changeEnded = replicatedStorage.Events.changeEnded
local tempLoc = replicatedStorage.Assets.TempLoc
local evolveSound = replicatedStorage.Assets.Audio.Evolve

local spawnPlayers = replicatedStorage.Events.SpawnPlayers

local function assignPlayerLocation(spawnedPlayers)	
	local numPlayers = #(game.Players:GetPlayers())
	local desiredDistance = (205/11) * numPlayers + 60
	
	local idealSpawn = nil
	local minErrorRate = 999999999

	for i, spawn in pairs(workspace.Map.Spawns:GetChildren()) do
		local errorRate = -1
		for j, player in pairs(spawnedPlayers) do
			local instanceErrorRate = math.abs(desiredDistance - (player.Character.HumanoidRootPart.Position - spawn.Position).Magnitude)
			if instanceErrorRate > errorRate then
				errorRate = instanceErrorRate
			end
		end
		
		if errorRate < minErrorRate then
			minErrorRate = errorRate
			idealSpawn = spawn
		end
	end
	return idealSpawn
end

function getPlayerTrail(plr)
	local playerFolder = replicatedStorage.StatFile:FindFirstChild(plr.Name)
	local statnumbers = playerFolder.statnumbers
	local lastTrail = statnumbers.lastTrail
	local trails = replicatedStorage.Assets.Trails
	print(lastTrail.Value)
	local trail = trails:FindFirstChild(lastTrail.Value).Trail:Clone()
	trail.Name = "Trail"

	trail.Parent = plr.Character.Head

	local attachment0 = Instance.new("Attachment", plr.Character.Head)
	attachment0.Name = "TrailAttachment0"
	trail.Attachment0 = attachment0

	local attachment1 = Instance.new("Attachment", plr.Character.HumanoidRootPart)
	attachment1.Name = "TrailAttachment1"
	trail.Attachment1 = attachment1
	return trail
end

function changePlayerModel(player, model, effect)
	
	print("Changing model")
	
	-- move the hummanoid
	local humanoid = player.Character.Humanoid
	changeStarted:FireClient(player)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	
	humanoid.BodyProportionScale.Value = model.Humanoid.BodyProportionScale.Value
	humanoid.BodyTypeScale.Value = model.Humanoid.BodyTypeScale.Value

	-- animal is a string of the name of the animal you want to change the character into
	for _, v in pairs(player.Character:GetChildren()) do
		if(v.Name ~= "HumanoidRootPart" and v.Name ~= "Humanoid" and v.Name ~= "Animate" and v.Name ~= "Health") then
			v:Destroy()
		end
	end

	for _, v in pairs(model:GetChildren()) do
		if(v.Name ~= "Humanoid" and v.Name ~= "HumanoidRootPart" and v.Name ~= "Animate" and v.Name ~= "Health") then
			local part = v:Clone()
			if part:IsA("BasePart") then
				part.Position = player.Character.HumanoidRootPart.Position
			end
			part.Parent = player.Character
		end
	end
	humanoid:BuildRigFromAttachments()
	
	wait()
	
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)

	--humanoid:ChangeState(8)
	
	local tag = player.Character.Head:FindFirstChild("playerInfo")
	
	if effect then
		createEvolutionEffect(player.Name, player.Character.HumanoidRootPart)
	end
	
	wait()
	changeEnded:FireClient(player)
	
	if replicatedStorage.StatFile[player.Name].playerStats.isSprinting.Value then
		getPlayerTrail(player)
	end
	
	if not tag then
		local clonedTag = replicatedStorage.Assets.Labels.playerInfo:Clone()
		clonedTag.Parent = player.Character.Head
	end
end

local function setUpPlayer(player)
	local playerFolder = statfile:FindFirstChild(player.Name)
	if playerFolder then
		playerFolder.playerStats.evoLvl.Changed:Connect(function()
			PlayerSize(player, playerFolder.playerStats.evoLvl.Value * SizePerEvolvl.Value + 1)
			local delta = 100 + playerFolder.playerStats.evoLvl.Value * HealthPerEvolvl.Value - player.Character.Humanoid.MaxHealth
			player.Character.Humanoid.MaxHealth = 100 + playerFolder.playerStats.evoLvl.Value * HealthPerEvolvl.Value
			if delta > 0 then
				player.Character.Humanoid.Health = player.Character.Humanoid.Health + delta
			end
			player.Character.Humanoid.JumpPower = math.max(0, 50 - playerFolder.playerStats.evoLvl.Value * JumpLossPerEvolvl.Value)
			player.Character.Humanoid.WalkSpeed = (16 + playerFolder.playerStats.evoLvl.Value * SpeedPerEvolvl.Value) * bool_to_number[playerFolder.playerStats.isSprinting.Value]
			--player.Character.Humanoid.WalkSpeed = (16 + delta * 0.25) * bool_to_number[playerFolder.playerStats.isSprinting.Value] * (1 + playerFolder.playerStats.evoLvl.Value * 0.05)
			--PlayerSize(player, math.log10(playerFolder.playerStats.evoLvl.Value) + 1)
		end)
		
		playerFolder.playerStats.isSprinting.Value = false
		local sprintSound = player.Character.HumanoidRootPart:FindFirstChild("Sprint")
		if sprintSound then
			sprintSound:Destroy()
		end
		
		player.Character.Humanoid.WalkSpeed = (16 + playerFolder.playerStats.evoLvl.Value * SpeedPerEvolvl.Value) * bool_to_number[playerFolder.playerStats.isSprinting.Value]
		player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		local line = lines[playerFolder.statnumbers.lastEquipped.Value]
		local linePos = playerFolder.playerStats.evoLinePos
		linePos.Value = 1
		wait(0.5)
		changePlayerModel(player, line[tostring(linePos.Value)], false)-- false

		playerFolder.playerStats.evoLvl.Changed:Connect(function()
			if (playerFolder.playerStats.evoLvl.Value >= THRESHOLD_ONE and linePos.Value == 1) then
				linePos.Value = 2
				changePlayerModel(player, line[tostring(linePos.Value)], true)
				-- If the player passes the second evolution stage
			elseif (playerFolder.playerStats.evoLvl.Value >= THRESHOLD_TWO and linePos.Value == 2) then
				linePos.Value = 3
				changePlayerModel(player, line[tostring(linePos.Value)], true)
			elseif (playerFolder.playerStats.evoLvl.Value < THRESHOLD_ONE and linePos.Value == 2) then
				linePos.Value = 1
				changePlayerModel(player, line[tostring(linePos.Value)], false) -- false
			elseif (playerFolder.playerStats.evoLvl.Value < THRESHOLD_TWO and linePos.Value == 3) then
				linePos.Value = 2
				changePlayerModel(player, line[tostring(linePos.Value)], false) -- false
			elseif (playerFolder.playerStats.evoLvl.Value >= THRESHOLD_TWO and linePos.Value == 1) then
				linePos.Value = 3
				changePlayerModel(player, line[tostring(linePos.Value)], true)
			elseif (playerFolder.playerStats.evoLvl.Value < THRESHOLD_ONE and linePos.Value == 3) then
				linePos.Value = 1
				changePlayerModel(player, line[tostring(linePos.Value)], false) -- false
			end
		end)
	end
end

function spawnPlayersIntoSpawnLocations()
	local availablePlayers = {}
	local spawnedPlayers = {}
	
	for i,v in pairs(game.Players:GetPlayers()) do
		table.insert(availablePlayers, v)
	end

	local firstPlayer = true

	while #availablePlayers > 0 do
		wait()
		local spawn = nil
		if firstPlayer then
			spawn = workspace.Map.Spawns:GetChildren()[math.random(#(workspace.Map.Spawns:GetChildren()))]
			firstPlayer = false
		else
			spawn = assignPlayerLocation(spawnedPlayers)
		end
		
		if availablePlayers[1] then
			availablePlayers[1].RespawnLocation = spawn
			replicatedStorage.StatFile[availablePlayers[1].Name].playerStats.evoLvl.Value = 1
			availablePlayers[1]:LoadCharacter()
		end
		replicatedStorage.StatFile[availablePlayers[1].Name].playerStats.isSpawned.Value = true
		table.insert(spawnedPlayers, availablePlayers[1])
		table.remove(availablePlayers, 1)
	end
end

function PlayerSize(player, SizeValue)
	-- SizeValue multiplies the Player's size by the selected amount
	
	local humanoid = player.Character:FindFirstChild("Humanoid")
	
	-- This can be changed to trigger when something happens, for example, when the player evolves
	if humanoid then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		--humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		if humanoid:FindFirstChild("BodyHeightScale") then
			humanoid.BodyHeightScale.Value = SizeValue
		end
		
		if humanoid:FindFirstChild("BodyWidthScale") then
			humanoid.BodyWidthScale.Value = SizeValue
		end

		if humanoid:FindFirstChild("BodyDepthScale") then
			humanoid.BodyDepthScale.Value = SizeValue
		end

		if humanoid:FindFirstChild("HeadScale") then
			humanoid.HeadScale.Value = SizeValue
		end
		
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
	end
	
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(player.Name)
	local playerStats = playerFolder.playerStats
	local head = player.Character:FindFirstChild("Head")
	if head then
		local tag = player.Character.Head:FindFirstChild("playerInfo")

		if not tag then
			local clonedTag = replicatedStorage.Assets.Labels.playerInfo:Clone()
			clonedTag.Parent = player.Character.Head
		end
	end
end

--changeSize.Event:Connect(PlayerSize)


-- test

local players = game:GetService("Players")
bool_to_number={ [true]=2, [false]=1 }

players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			print("died")
			if inRound.Value then
				local playerFolder = replicatedStorage.StatFile:FindFirstChild(player.Name)
				if playerFolder then
					replicatedStorage.StatFile[player.Name].playerStats.isSpawned.Value = false
					local killedEvo
					killedEvo = math.ceil(replicatedStorage.StatFile:FindFirstChild(character.Name).playerStats.evoLvl.Value / 2)
					print("EVOLVL: " .. replicatedStorage.StatFile:FindFirstChild(character.Name).playerStats.evoLvl.Value)
					print("KILLED EVO: " .. killedEvo)
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						print("WE ARE DROPPING MEAT")
						for i=1, killedEvo do
							local power = replicatedStorage.Assets.MeatPowerups.Meat:Clone()
							power.killedPlayer.Value = character.Name
							power.timeStamp.Value = tick()
							power.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
							power.Parent = workspace.Powerups
						end
					end
					
					playerFolder.playerStats.evoLvl.Value = 1

					local spawnedPlayers = {}
					for i, playerFolder in pairs(replicatedStorage.StatFile:GetChildren()) do
						if playerFolder.playerStats.isSpawned.Value then
							if game.Players:FindFirstChild(playerFolder.Name) then
								table.insert(spawnedPlayers, players[playerFolder.Name])
							end
						end
					end
					

					local spawn = nil
					if #spawnedPlayers > 0 then
						local success, spawnFound, err = pcall(assignPlayerLocation, spawnedPlayers)

						if not success then
							warn(err)
						else
							print("Found the spawn")
							spawn = spawnFound
						end
					elseif not spawn then
						warn("No spawn was found")
						spawn = workspace.Map.Spawns:GetChildren()[math.random(#(workspace.Map.Spawns:GetChildren()))]
					end
					if player then
						player.RespawnLocation = spawn
						player:LoadCharacter()
					end
				end
			else
				print("died in lobby")
				local lobbySpawns = workspace.lobby.Spawns:GetChildren()
				local chosenSpawn = lobbySpawns[math.random(#lobbySpawns)]
				if player then
					player.RespawnLocation = chosenSpawn
					player:LoadCharacter()
				end
			end
		end)

		if inRound.Value then
			repeat wait() until player and character and game.ReplicatedStorage.StatFile:FindFirstChild(player.Name)
			local HRP = character:WaitForChild("HumanoidRootPart")
			wait()
			setUpPlayer(player)
			if replicatedStorage.StatFile:FindFirstChild(character.Name) then
				replicatedStorage.StatFile[character.Name].playerStats.isSpawned.Value = true
			end
		end
	end)
	if inRound.Value then			
		
		local spawnedPlayers = {}
		for i, playerFolder in pairs(replicatedStorage.StatFile:GetChildren()) do
			if playerFolder.playerStats.isSpawned.Value then
				if players:FindFirstChild(playerFolder.Name) then
					table.insert(spawnedPlayers, players[playerFolder.Name])
				end
			end
		end

		local spawn = nil
		if #spawnedPlayers > 0 then
			local success, spawnFound, err = pcall(assignPlayerLocation, spawnedPlayers)
			if not success then
				warn(err)
			else
				spawn = spawnFound
				print("Found the spawn")
			end
		elseif not spawn then
			spawn = workspace.Map.Spawns:GetChildren()[math.random(#(workspace.Map.Spawns:GetChildren()))]
		end
		if player then
			player.RespawnLocation = spawn
			player:LoadCharacter()
		end
	else
		local lobbySpawns = workspace.lobby.Spawns:GetChildren()
		local chosenSpawn = lobbySpawns[math.random(#lobbySpawns)]
		if player then
			player.RespawnLocation = chosenSpawn
			player:LoadCharacter()
		end
	end
end)

function createEvolutionEffect(name, humanoidRootPart)
	
	local playerFolder = replicatedStorage.StatFile:FindFirstChild(name)
	local statnumbers = playerFolder.statnumbers
	local particleName = statnumbers.lastEffect
	
	local soundCopy = evolveSound:Clone()
	soundCopy.Parent = humanoidRootPart
	
	soundCopy.RollOffMaxDistance = 40 + playerFolder.playerStats.evoLvl.Value * 2.45
	soundCopy.RollOffMinDistance = 20 + playerFolder.playerStats.evoLvl.Value * 2.45
	soundCopy:Play()
	
	local effect = replicatedStorage.Assets.Effects:FindFirstChild(particleName.Value):Clone()
	local evoBall = effect.PrimaryPart
	evoBall.Parent = humanoidRootPart
	evoBall.Position = humanoidRootPart.Position
	local maxCoord = math.max(humanoidRootPart.Parent:GetExtentsSize().X, humanoidRootPart.Parent:GetExtentsSize().Y, humanoidRootPart.Parent:GetExtentsSize().Z)
	evoBall.Size = Vector3.new(maxCoord * 1.2, maxCoord * 1.2, maxCoord * 1.2)
	evoBall.Weld.Part1 = humanoidRootPart
	
	evoBall.EvolutionEffect.Transparency = NumberSequence.new(0)
	evoBall.Transparency = NumberSequence.new(0)
	
	
	evoBall.EvolutionEffect.Rate = 80
	evoBall.EvolutionEffect.Speed = NumberRange.new(50)
	
	wait(0.2)
	-- fade away
	for x=0,3,0.05 do
		evoBall.EvolutionEffect.Transparency = NumberSequence.new( 1 / (1 + math.exp(-3 * (x-1))))
		evoBall.Transparency = 1 / (1 + math.exp(-3 * (x-1) ) )
		wait(0.05)
	end
	
	evoBall:Destroy()
	soundCopy:Destroy()
end

spawnPlayers.Event:Connect(spawnPlayersIntoSpawnLocations)