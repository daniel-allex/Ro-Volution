math.randomseed(tick())

local openEvent = game.ReplicatedStorage.Events.openCrate
local buyCrateEvent = game.ReplicatedStorage.Events.buyCrate
local initiateDailyReward = game.ReplicatedStorage.Events.initiateDailyReward
local awardClient = game.ReplicatedStorage.Events.awardClient
local SendSystemMessage = game.ReplicatedStorage.Events.SendSystemMessage

local compensationRarities = {
	[0] = 1000,
	[1] = 2000,
	[2] = 4000,
	[3] = 10000,
	[4] = 14000
}

local rarities = {
	[0] = {["Name"] = "Common",
		["Color"] = Color3.new(117/255, 117/255, 117/255)
	},
	[1] = {["Name"] = "Rare",
		["Color"] = Color3.new(30/255, 136/255, 229/255)
	},
	[2] = {["Name"] = "Very Rare",
		["Color"] = Color3.new(126/255, 87/255, 194/255)
	},
	[3] = {["Name"] = "Mythic",
		["Color"] = Color3.new(240/255, 98/255, 146/255)
	},
	[4] = {["Name"] = "Legendary",
		["Color"] = Color3.new(211/255, 47/255, 47/255)
	}
}

local getCrateFromStreak = {
	[0] = "Wood Crate",
	[1] = "Stone Crate",
	[2] = "Stone Crate",
	[3] = "Iron Crate",
	[4] = "Gold Crate",
	[5] = "Ruby Crate",
	[6] = "Diamond Crate"
}

local function chooseRarity(crate)
	local randNum = math.random(100)
	local selected
	local Rarities = crate.Data.Rarities
	
	if randNum <= Rarities["Common"].Value then
		selected = 0
	elseif randNum <= Rarities["Common"].Value + Rarities["Rare"].Value then
		selected = 1
	elseif randNum <= Rarities["Common"].Value + Rarities["Rare"].Value + Rarities["Very Rare"].Value then
		selected = 2
	elseif randNum <= Rarities["Common"].Value + Rarities["Rare"].Value + Rarities["Very Rare"].Value + Rarities["Mythic"].Value then
		selected = 3
	else
		selected = 4
	end
	--print("chosen!".. selected)
	return selected
end

local function openCrate(plr, crate)
	local compensation = 0
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name)
	
	if playerFolder then
		if playerFolder.Crates:FindFirstChild(crate.Name) then
			local selectedRarity = chooseRarity(crate)
			local options = {}
			for i,v in pairs(game.ReplicatedStorage.EvolutionLines:GetChildren()) do
				if v.rarity.Value == selectedRarity and v.Name ~= "Dog" then
					table.insert(options, v)
				end
			end
			
			for i,v in pairs(game.ReplicatedStorage.Assets.Effects:GetChildren()) do
				if v.rarity.Value == selectedRarity and v.Name ~= "White Circle" then
					table.insert(options, v)
				end
			end
			
			for i,v in pairs(game.ReplicatedStorage.Assets.Trails:GetChildren()) do
				if v.rarity.Value == selectedRarity and v.Name ~= "White Dash" then
					table.insert(options, v)
				end
			end
			
			local selectedItem
			selectedItem = options[math.random(#options)]
			
			
			local folder
			if selectedItem.Parent.Name == "EvolutionLines" then
				if playerFolder.Evolutions:FindFirstChild(selectedItem.Name) then
					compensation = compensationRarities[selectedRarity]
				else
					folder = Instance.new("Folder")
					folder.Name = selectedItem.Name
					folder.Parent = playerFolder.Evolutions
				end
			elseif selectedItem.Parent.Name == "Trails" then
				if playerFolder.Trails:FindFirstChild(selectedItem.Name) then
					compensation = compensationRarities[selectedRarity]
				else
					folder = Instance.new("Folder")
					folder.Name = selectedItem.Name
					folder.Parent = playerFolder.Trails
				end
			else
				if playerFolder.Effects:FindFirstChild(selectedItem.Name) then
					compensation = compensationRarities[selectedRarity]
				else
					folder = Instance.new("Folder")
					folder.Name = selectedItem.Name
					folder.Parent = playerFolder.Effects
				end
			end
			
			playerFolder.Crates[crate.Name]:Destroy()
			playerFolder.statnumbers.animalBux.Value = playerFolder.statnumbers.animalBux.Value + compensation
			
			if playerFolder.statnumbers.firstDailyReward.Value == true then
				playerFolder.statnumbers.firstDailyReward.Value = false
			end
			local msg = "[SYSTEM] " .. plr.Name .. " has won the " .. selectedItem.Name .. " from a " .. crate.Name .. "!"
			SendSystemMessage:FireAllClients(msg, rarities[selectedRarity].Color, 7)
			
			return({["Item"] = selectedItem, ["Compensation"] = compensation})
		end
	end
end

openEvent.OnServerInvoke = openCrate

local function buyCrate(plr, crate)
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name)

	if playerFolder then
		if playerFolder.statnumbers.animalBux.Value >= crate.Data.Price.Value  then
			local newCrate = Instance.new("Folder")
			newCrate.Name = crate.Name
			newCrate.Parent = playerFolder.Crates
			playerFolder.statnumbers.animalBux.Value = playerFolder.statnumbers.animalBux.Value - crate.Data.Price.Value
			
			if playerFolder.statnumbers.firstTimePlaying.Value == true then
				playerFolder.statnumbers.firstTimePlaying.Value = false
			end
		end
	end
end

buyCrateEvent.OnServerEvent:Connect(buyCrate)

local function giveDailyAward(plr, streak)
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name)

	if playerFolder then
		local crate = getCrateFromStreak[streak]
		local newCrate = Instance.new("Folder")
		newCrate.Name = crate
		newCrate.Parent = playerFolder.Crates		
		playerFolder.statnumbers.lastRewarded.Value = os.time()
		awardClient:FireClient(plr, streak)
	end
end

initiateDailyReward.Event:Connect(giveDailyAward)