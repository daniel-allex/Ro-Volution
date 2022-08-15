local replicatedStorage = game:GetService("ReplicatedStorage")

statfile = replicatedStorage:WaitForChild("StatFile")

local increase = replicatedStorage.Events.IncreaseWalkspeed
local decrease = replicatedStorage.Events.DecreaseWalkspeed

local playerActivations = {}

function getPlayerTrail(plr)
	local playerFolder = replicatedStorage.StatFile:FindFirstChild(plr.Name)
	if playerFolder then
		local statnumbers = playerFolder.statnumbers
		local lastTrail = statnumbers.lastTrail
		local trails = replicatedStorage.Assets.Trails
		local sprintSound = replicatedStorage.Assets.Audio.Sprint:Clone()
		local boostSound = replicatedStorage.Assets.Audio.Boost:Clone()
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

		sprintSound.Parent = plr.Character.HumanoidRootPart
		boostSound.Parent = plr.Character.HumanoidRootPart

		boostSound.RollOffMaxDistance = 40 + playerFolder.playerStats.evoLvl.Value * 2.45
		boostSound.RollOffMinDistance = 20 + playerFolder.playerStats.evoLvl.Value * 2.45
		
		sprintSound.RollOffMaxDistance = 40 + playerFolder.playerStats.evoLvl.Value * 2.45
		sprintSound.RollOffMinDistance = 20 + playerFolder.playerStats.evoLvl.Value * 2.45

		boostSound:Play()
		sprintSound:Play()

		return trail
	end
end

increase.OnServerEvent:Connect(function(player)
	print("step 1")
	local playerFolder = statfile:FindFirstChild(player.Name)
	
	if playerFolder then
		print("step 2")

		if playerFolder.playerStats.isSprinting.Value then
			return
		end
		
		print("step 3")

		playerActivations[player.Name] = true
		playerFolder.playerStats.isSprinting.Value = true

		local trail = getPlayerTrail(player)
		local playerEvo = replicatedStorage.StatFile:WaitForChild(player.Name).playerStats.evoLvl
		player.Character.Humanoid.WalkSpeed = (16 + playerEvo.Value * 0.3) * 2	
		
		if replicatedStorage.RoundStatus.inRound.Value then
			while playerActivations[player.Name] == true and playerEvo.Value > 1.1 do
				playerEvo.Value -= 1	
				wait(1)
			end
			
			if player.Character.Head:FindFirstChild("Trail") then
				player.Character.Head.Trail:Destroy()
			end

			if player.Character.HumanoidRootPart:FindFirstChild("Sprint") then
				player.Character.HumanoidRootPart.Sprint:Destroy()
			end

			if player.Character.HumanoidRootPart:FindFirstChild("Boost") then
				player.Character.HumanoidRootPart.Boost:Destroy()
			end

			local playerFolder = statfile:WaitForChild(player.Name)
			playerFolder.playerStats.isSprinting.Value = false

			player.Character.Humanoid.WalkSpeed = 16 + playerFolder.playerStats.evoLvl.Value * 0.3
			
		else
			player.Character.Humanoid.WalkSpeed = 34
		end		
	end
end)

decrease.OnServerEvent:Connect(function(player)
	playerActivations[player.Name] = false
	
	if replicatedStorage.RoundStatus.inRound.Value == false then
		if player.Character.Head:FindFirstChild("Trail") then
			player.Character.Head.Trail:Destroy()
		end

		if player.Character.HumanoidRootPart:FindFirstChild("Sprint") then
			player.Character.HumanoidRootPart.Sprint:Destroy()
		end

		if player.Character.HumanoidRootPart:FindFirstChild("Boost") then
			player.Character.HumanoidRootPart.Boost:Destroy()
		end

		local playerFolder = statfile:WaitForChild(player.Name)
		playerFolder.playerStats.isSprinting.Value = false

		player.Character.Humanoid.WalkSpeed = 16
	end
end)

replicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	for i,player in pairs(game.Players:GetChildren()) do
		if replicatedStorage.RoundStatus.inRound.Value == false then
			if player.Character.Head:FindFirstChild("Trail") then
				player.Character.Head.Trail:Destroy()
			end

			if player.Character.HumanoidRootPart:FindFirstChild("Sprint") then
				player.Character.HumanoidRootPart.Sprint:Destroy()
			end

			if player.Character.HumanoidRootPart:FindFirstChild("Boost") then
				player.Character.HumanoidRootPart.Boost:Destroy()
			end

			local playerFolder = statfile:WaitForChild(player.Name)
			playerFolder.playerStats.isSprinting.Value = false

			player.Character.Humanoid.WalkSpeed = 16
		end
	end
end)