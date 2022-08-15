-- Services
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local workSpace = game:GetService("Workspace")
local marketplaceService = game:GetService("MarketplaceService")

local statfile = replicatedStorage:WaitForChild("StatFile")
-- Events
local endRound = replicatedStorage.Events.EndRound
local gameScores = replicatedStorage.Events.GameScores
local autoSave = replicatedStorage.Events.AutoSave

-- GUI
local leaderboard = replicatedStorage.Assets.GUI.Leaderboard
local tempLoc = replicatedStorage.Assets.TempLoc

local places = {
	[1] = {
		["Text"] = "1st",
		["Color"] = Color3.new(245/255, 127/255, 23/255)},
	[2] = {
		["Text"] = "2nd",
		["Color"] = Color3.new(158/255, 158/255, 158/255)},
	[3] = {
		["Text"] = "3rd",
		["Color"] = Color3.new(161/255, 136/255, 127/255)},
	[4] = {
		["Text"] = "4th",
		["Color"] = Color3.new(0, 0, 0)},
	[5] = {
		["Text"] = "5th",
		["Color"] = Color3.new(0, 0, 0)},
	[6] = {
		["Text"] = "6th",
		["Color"] = Color3.new(0, 0, 0)},
	[7] = {
		["Text"] = "7th",
		["Color"] = Color3.new(0, 0, 0)},
	[8] = {
		["Text"] = "8th",
		["Color"] = Color3.new(0, 0, 0)},
	[9] = {
		["Text"] = "9th",
		["Color"] = Color3.new(0, 0, 0)},
	[10] = {
		["Text"] = "10th",
		["Color"] = Color3.new(0, 0, 0)},
	[11] = {
		["Text"] = "11th",
		["Color"] = Color3.new(0, 0, 0)},
	[12] = {
		["Text"] = "12th",
		["Color"] = Color3.new(0, 0, 0)},
	[13] = {
		["Text"] = "13th",
		["Color"] = Color3.new(0, 0, 0)},
	[14] = {
		["Text"] = "14th",
		["Color"] = Color3.new(0, 0, 0)}
}

-- Functions
local function calculateAnimalBux(place, size, players)	
	local total = (players - place + 1) * 280
		
	return total
end

local function getGameWinner()
	-- Create a table of players and their scores in descending order (greatest score first)
	-- format: { {player name, evoLvl}, ...}
	local playerScores = {}
	for i, playerFolder in pairs(statfile:GetChildren()) do
		playerScores[#playerScores + 1] = {
			["Name"] = playerFolder.Name,
			["EvoLvl"] = playerFolder.playerStats.evoLvl.Value
		}
	end
	table.sort(playerScores, function (v1, v2)
		return v1.EvoLvl > v2.EvoLvl --sorted in reverse order
	end)
	return playerScores
end


local function setUpLeaderboard(playerScores)
	if tempLoc:FindFirstChild("Leaderboard") then
		tempLoc.Leaderboard:Destroy()
	end
	
	local copiedLeaderboard = leaderboard:Clone()
	local leftTemplate = copiedLeaderboard.frmSelection.Evolutions.frmLeft.Template
	local rightTemplate = copiedLeaderboard.frmSelection.Evolutions.frmRight.Template
	local side = "Left"
	local MAX_COLUMN = 7
	
	local count = 0
	local place = 0
	local lastEvoLvl = -1
	local success, err = pcall(function()

		for i,v in pairs(playerScores) do
			if game.Players:FindFirstChild(v.Name) then

				count = count + 1
				if count == MAX_COLUMN + 1 then
					if side == "Left" then
						count = 0
						side = "Right"
					else
						break
					end
				end
				
				if lastEvoLvl == v.EvoLvl then
				else
					place = place + 1
					lastEvoLvl = v.EvoLvl
					if place == 1 then
						replicatedStorage.StatFile[v.Name].statnumbers.Wins.Value = replicatedStorage.StatFile[v.Name].statnumbers.Wins.Value + 1
					end
				end
				
				if side == "Left" then
					local clone = leftTemplate:Clone()
					clone.Parent = copiedLeaderboard.frmSelection.Evolutions.frmLeft
					clone.txtName.Text = v.Name
					clone.txtPlace.Text = places[place].Text
					clone.txtPlace.TextColor3 = places[place].Color
					clone.txtSize.Text = "Size: " .. v.EvoLvl
					local earnedAnimalBux = calculateAnimalBux(place, v.EvoLvl, #(players:GetChildren()))
					if game.Players:FindFirstChild(v.Name) then
						local player = game.Players:FindFirstChild(v.Name)
						if marketplaceService:UserOwnsGamePassAsync(player.UserId, replicatedStorage.Assets.Gamepasses.DoubleTokens.Value) then
							earnedAnimalBux = earnedAnimalBux * 2
							clone.txtEarned.TextColor3 = places[1].Color
						end
						clone.txtEarned.Text = earnedAnimalBux
						replicatedStorage.StatFile[v.Name].statnumbers.animalBux.Value  = replicatedStorage.StatFile[v.Name].statnumbers.animalBux.Value + earnedAnimalBux
					
					clone.imgPlayer.Image = players:GetUserThumbnailAsync(players[v.Name].UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
					end
				elseif side == "Right" then
					local clone = rightTemplate:Clone()
					clone.Parent = copiedLeaderboard.frmSelection.Evolutions.frmRight
					clone.txtName.Text = v.Name
					clone.txtPlace.Text = places[place].Text
					clone.txtPlace.TextColor3 = places[place].Color
					clone.txtSize.Text = "Size: " .. v.EvoLvl
					local earnedAnimalBux = calculateAnimalBux(place, v.EvoLvl, #(players:GetChildren()))
					if game.Players:FindFirstChild(v.Name) then
						local player = game.Players:FindFirstChild(v.Name)
						if marketplaceService:UserOwnsGamePassAsync(player.UserId, replicatedStorage.Assets.Gamepasses.DoubleTokens.Value) then
							earnedAnimalBux = earnedAnimalBux * 2
							clone.txtEarned.TextColor3 = places[1].Color
						end
						clone.txtEarned.Text = earnedAnimalBux
						replicatedStorage.StatFile[v.Name].statnumbers.animalBux.Value  = replicatedStorage.StatFile[v.Name].statnumbers.animalBux.Value + earnedAnimalBux
						clone.imgPlayer.Image = players:GetUserThumbnailAsync(players[v.Name].UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
					end	
				end
			end
		end
	end)
	
	if not success then
		warn(err)
	end
	leftTemplate:Destroy()
	rightTemplate:Destroy()
	
	copiedLeaderboard.Parent = tempLoc
end

local function resetEvoLvls()
	-- sets every player's evo lvl equal to zero
	for i, playerFolder in pairs(statfile:GetChildren()) do
		if playerFolder then
			playerFolder.playerStats.evoLvl.Value = 1
			playerFolder.playerStats.stompLevel.Value = 0
		end
	end	
end

-- Connection Functions
local function endTheRound()
	local Success1, scores, err1 = pcall(getGameWinner)
	
	if not Success1 then
		warn(err1)
	end
	
	local Success2, err2 = pcall(setUpLeaderboard, scores)
	
	if not Success2 then
		warn(err2)
	end
	
	local Success3, err3 = pcall(resetEvoLvls)
	
	if not Success3 then
		warn(err3)
	end
	
	autoSave:Fire()
end

endRound.Event:Connect(endTheRound)