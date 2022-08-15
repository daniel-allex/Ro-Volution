-- This script is temporary, will move into other local script soon

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Statfile = ReplicatedStorage:WaitForChild("StatFile")

local ACTION_SPRINT = "Sprint"
local sprintButtonToggled = false

local inRound = ReplicatedStorage.RoundStatus.inRound

local IncreaseWalkspeed = ReplicatedStorage.Events.IncreaseWalkspeed
local DecreaseWalkspeed = ReplicatedStorage.Events.DecreaseWalkspeed

local spedUp = false

local function handleAction(actionName, inputState)
	if actionName == ACTION_SPRINT then
		print("This input was a sprint")

		if inputState == Enum.UserInputState.Begin and not spedUp then
			print("Sprint ON")
			spedUp = true
			player.Character.Humanoid.WalkSpeed = 50
			
			local playerFolder = ReplicatedStorage.StatFile:FindFirstChild(player.Name)
			local statnumbers = playerFolder.statnumbers
			local lastTrail = statnumbers.lastTrail
			local trails = ReplicatedStorage.Assets.Trails
			local sprintSound = ReplicatedStorage.Assets.Audio.Sprint:Clone()
			local boostSound = ReplicatedStorage.Assets.Audio.Boost:Clone()
			print(lastTrail.Value)
			local trail = trails:FindFirstChild(lastTrail.Value).Trail:Clone()
			trail.Name = "Trail"

			trail.Parent = player.Character.Head
			
			local attachment0 = Instance.new("Attachment", player.Character.Head)
			attachment0.Name = "TrailAttachment0"
			trail.Attachment0 = attachment0

			local attachment1 = Instance.new("Attachment", player.Character.HumanoidRootPart)
			attachment1.Name = "TrailAttachment1"
			trail.Attachment1 = attachment1
			
			sprintSound.Parent = player.Character.HumanoidRootPart
			boostSound.Parent = player.Character.HumanoidRootPart

			boostSound.RollOffMaxDistance = 25 + playerFolder.playerStats.evoLvl.Value * 2
			boostSound.RollOffMinDistance = 10 + playerFolder.playerStats.evoLvl.Value * 2

			sprintSound.RollOffMaxDistance = 25 + playerFolder.playerStats.evoLvl.Value * 2
			sprintSound.RollOffMinDistance = 10 + playerFolder.playerStats.evoLvl.Value * 2

			boostSound:Play()
			sprintSound:Play()
			return
		elseif inputState == Enum.UserInputState.End and spedUp == true then
			print("Sprint OFF")
			spedUp = false	
			player.Character.Humanoid.WalkSpeed = 16
			
			if player.Character.Head:FindFirstChild("Trail") then
				player.Character.Head.Trail:Destroy()
			end

			if player.Character.HumanoidRootPart:FindFirstChild("Sprint") then
				player.Character.HumanoidRootPart.Sprint:Destroy()
			end

			if player.Character.HumanoidRootPart:FindFirstChild("Boost") then
				player.Character.HumanoidRootPart.Boost:Destroy()
			end
			
		end
	end
end

if inRound.Value == false then
	ContextActionService:BindAction(ACTION_SPRINT, handleAction, false, Enum.KeyCode.LeftShift)
else
	player.Character.Humanoid.WalkSpeed = 16
end
