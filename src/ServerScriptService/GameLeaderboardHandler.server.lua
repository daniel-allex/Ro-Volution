local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local inRound = replicatedStorage.RoundStatus.inRound
local tempLoc = replicatedStorage.Assets.TempLoc

local function leaderboardSetup(player)
	local playerFolder = replicatedStorage.StatFile:WaitForChild(player.Name)
	local playerStats = playerFolder:WaitForChild("playerStats")
	local statnumbers = playerFolder:WaitForChild("statnumbers")
	local actualValue = playerStats.evoLvl
	local actualWins = statnumbers.Wins
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local evoLvl = Instance.new("IntValue")
	evoLvl.Name = "Size"
	evoLvl.Value = actualValue.Value
	
	local Wins = Instance.new("IntValue")
	Wins.Name = "Wins"
	Wins.Value = actualWins.Value
	
	if inRound.Value == true then
		evoLvl.Parent = leaderstats
		Wins.Parent = tempLoc
	else
		Wins.Parent = leaderstats
		evoLvl.Parent = tempLoc
	end
	
	actualValue.Changed:Connect(function()
		evoLvl.Value = actualValue.Value
	end)
	
	actualWins.Changed:Connect(function()
		Wins.Value = actualWins.Value
	end)
	
	inRound.Changed:Connect(function()
		if inRound.Value == true then
			evoLvl.Parent = leaderstats
			Wins.Parent = tempLoc
		else
			Wins.Parent = leaderstats
			evoLvl.Parent = tempLoc
		end
	end)
end

-- Connect the "leaderboardSetup()" function to the "PlayerAdded" event
Players.PlayerAdded:Connect(leaderboardSetup)