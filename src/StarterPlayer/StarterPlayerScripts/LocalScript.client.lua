local replicatedStorage = game:GetService("ReplicatedStorage")
local player = game:GetService("Players").LocalPlayer

local changeStarted = replicatedStorage.Events.changeStarted
local changeEnded = replicatedStorage.Events.changeEnded

changeStarted.OnClientEvent:Connect(function ()
	player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
end)

changeEnded.OnClientEvent:Connect(function ()
	player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
end)