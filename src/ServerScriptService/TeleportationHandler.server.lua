math.randomseed(tick())

-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- Events
local charactersLoaded = replicatedStorage.Events.charactersLoaded
local startRound = replicatedStorage.Events.StartRound
local endRound = replicatedStorage.Events.EndRound
local playersToLoad = nil
local spawnPlayers = replicatedStorage.Events.SpawnPlayers
local mapLoaded = replicatedStorage.Events.mapLoaded

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


function RandomizeTable(tbl)
	local returntbl={}
	if tbl[1]~=nil then
		for i=1,#tbl do
			table.insert(returntbl,math.random(1,#returntbl+1),tbl[i])
		end
	end
	return returntbl
end

function chooseRandomMap()
	local maps = replicatedStorage.Assets.Maps:GetChildren()
	local map = maps[math.random(#maps)]:Clone()
	local chosen = map.Name
	mapLoaded:FireAllClients(map.Name)
	map.Name = "Map"
	map.Parent = workspace
	return chosen
end

function deleteMapFromWorkspace()
	workspace.Map:Destroy()
end

-- Connection Functions
function startTheRound()
	local pickedMap = chooseRandomMap()
	wait(3)
	game.ReplicatedStorage.RoundStatus.inRound.Value = true
	local musicCopy = MapToSound[pickedMap]:Clone()
	musicCopy.Parent = workspace
	musicCopy:Play()
	wait(3)
	spawnPlayers:Fire()
end

function endTheRound()
	local leaderboard = replicatedStorage.Assets.TempLoc:WaitForChild("Leaderboard", 15)
	wait(.1)
	game.ReplicatedStorage.RoundStatus.inRound.Value = false
	workspace.Powerups:ClearAllChildren()
	wait(5)
	
	local spawns = {}
	
	for i,v in pairs(game.Workspace.lobby.Spawns:GetChildren()) do
		table.insert(spawns, v)
	end
	
	local success, err = pcall(function()
		spawns = RandomizeTable(spawns)

		for i, player in pairs(game.Players:GetPlayers()) do
			if player then
				if replicatedStorage.StatFile:FindFirstChild(player.Name) then
					replicatedStorage.StatFile[player.Name].playerStats.isSpawned.Value = false

					player.RespawnLocation = spawns[i]
					player:LoadCharacter()
				end
			end
		end
	end)
	
	if not success then
		warn(err)
	end
	
	deleteMapFromWorkspace()
end

-- Connect
--charactersLoaded.Event:Connect(startTheRound)
startRound.Event:Connect(startTheRound)
endRound.Event:Connect(endTheRound)