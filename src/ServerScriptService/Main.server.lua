-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

--ll
local roundLength  = replicatedStorage.GameParams.RoundLength.Value
local intermissionLength = replicatedStorage.GameParams.IntermissionLength.Value
local status = replicatedStorage.RoundStatus.Status

-- Events
local startRound = replicatedStorage.Events.StartRound
local endRound = replicatedStorage.Events.EndRound

-- Music
local Jungle = replicatedStorage.Assets.Audio.Jungle
local Snow = replicatedStorage.Assets.Audio.Snow
local Island = replicatedStorage.Assets.Audio.Island
local LobbyMusic = replicatedStorage.Assets.Audio.Lobby
local EndRoundMusic = replicatedStorage.Assets.Audio.WinScreen

local MapToSound = {
	["Grass Map"] = Jungle,
	["Snow Map"] = Snow,
	["Island Map"] = Island
}

function toMS(s)
	if s >= 60 then
		return string.format("%02i:%02i", s/60, s%60)
	end
	return tostring(s)
end

-- Timer for the Intermission and Game 
while wait() do
	local musicCopy = LobbyMusic:Clone()
	musicCopy.Parent = workspace
	musicCopy:Play()
	if #players:GetChildren() < 2 then
		status.Value = "Invite your friends! 2 Players needed to start"
		repeat wait() until #players:GetChildren() >= 2
	end	

	-- Intermission Timer
	for i = intermissionLength, 0, -1 do
		wait(1)
		status.Value = "Starting in ".. toMS(i)
	end
	
	status.Value = "Choosing Map..."
	
	wait(1)

	
	startRound:Fire()
	
	musicCopy:Destroy()

	
	status.Value = "Starting Round..."
	wait(4)
	
	
	-- Game Timer
	for i = roundLength, 1, -1 do
		wait(1)
		status.Value =  toMS(i)
	end 
	
	status.Value = "Round Ended"

	endRound:Fire()
	musicCopy:Destroy()
	if game.Workspace:FindFirstChild("Jungle") then
		workspace.Jungle:Destroy()
	end
	
	if game.Workspace:FindFirstChild("Snow") then
		workspace.Snow:Destroy()
	end
	
	if game.Workspace:FindFirstChild("Island") then
		workspace.Island:Destroy()
	end
	
	musicCopy = EndRoundMusic:Clone()
	musicCopy.Parent = workspace
	musicCopy:Play()
	
	repeat wait() until not game.Workspace:FindFirstChild("Map")
	musicCopy:Destroy()
end