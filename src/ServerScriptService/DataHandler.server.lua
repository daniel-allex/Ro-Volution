local players = game:GetService("Players")
local saveEvent = game.ReplicatedStorage.Events.Save
local autoEvent = game.ReplicatedStorage.Events.AutoSave
local SendSystemMessage = game.ReplicatedStorage.Events.SendSystemMessage
local enterTwitterCode = game.ReplicatedStorage.Events.enterTwitterCode
local invitedPlayers = game.ReplicatedStorage.Events.invitedPlayers
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("RealDataV3.2")
local marketplaceService = game:GetService("MarketplaceService")
local sendNotification = game.ReplicatedStorage.Events.sendNotification
local inviters = {}

local FRIEND_INVITE_REWARD = 300
local REFER_REWARD = 1000
local GROUP_REWARD = 800

local cache = {}
function getUsernameFromUserId(userId)
	-- First, check if the cache contains the name
	if cache[userId] then return cache[userId] end
	-- Second, check if the user is already connected to the server
	local player = players:GetPlayerByUserId(userId)
	if player then
		cache[userId] = player.Name
		return player.Name
	end 
	-- If all else fails, send a request
	local name
	pcall(function ()
		name = players:GetNameFromUserIdAsync(userId)
	end)
	cache[userId] = name
	return name
end

local idcache = {}
function getUserIdFromUsername(name)
	-- First, check if the cache contains the name
	if idcache[name] then return idcache[name] end
	-- Second, check if the user is already connected to the server
	local player = players:FindFirstChild(name)
	if player then
		idcache[name] = player.UserId
		return player.UserId
	end 
	-- If all else fails, send a request
	local id
	pcall(function ()
		id = players:GetUserIdFromNameAsync(name)
	end)
	idcache[name] = id
	return id
end

local function Save(plr)	
	local key = "plr-"..plr.UserId
	local save = {
		 		  ["Evolutions"] = {},
		 		  ["Trails"] = {},
				  ["Effects"] = {},
				  ["Crates"] = {},
				  ["statnumbers"] = {},
				  ["TwitterCodes"] = {}
	}
	
	if game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name) then
		for i,v in pairs(game.ReplicatedStorage.StatFile[plr.Name].statnumbers:GetChildren()) do
			save.statnumbers[v.Name] = v.Value
		end
		
		for i,v in pairs(game.ReplicatedStorage.StatFile[plr.Name].Evolutions:GetChildren()) do
			if v.Name ~= "Robots" and v.Name ~= "Yeti" and v.Name ~= "Pumpkin" then
				table.insert(save.Evolutions, v.Name)
			end
		end
		
		for i,v in pairs(game.ReplicatedStorage.StatFile[plr.Name].Effects:GetChildren()) do
			if v.Name ~= "Fusion Effect" then
				table.insert(save.Effects, v.Name)
			end
		end
		
		for i,v in pairs(game.ReplicatedStorage.StatFile[plr.Name].Trails:GetChildren()) do
			if v.Name ~= "Fusion Dash" then
				table.insert(save.Trails, v.Name)
			end
		end
		
		for i,v in pairs(game.ReplicatedStorage.StatFile[plr.Name].Crates:GetChildren()) do
			table.insert(save.Crates, v.Name)
		end
		
		for i,v in pairs(game.ReplicatedStorage.StatFile[plr.Name].TwitterCodes:GetChildren()) do
			table.insert(save.TwitterCodes, v.Name)
		end
	end
	
	local success, err = pcall(function()
		DataStore:SetAsync(key, save)
	end)
	
	if not success then
		warn("Failed to overwrite data "..tostring(err))
		return
	end
end

local function autoSave()
	for _, plr in ipairs(game.Players:GetPlayers()) do
		if plr then
			local plrFolder = game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name)
			if plrFolder then
				local statnumbers = plrFolder.statnumbers
				local success, err = pcall(function()
					if statnumbers.receivedGroupReward.Value == false and plr:IsInGroup(8386264) then
						statnumbers.receivedGroupReward.Value = true
						statnumbers.animalBux.Value = statnumbers.animalBux.Value + GROUP_REWARD
						local msg = "[SYSTEM] " .. plr.Name .. " was rewarded 800 Tokens for joining the Ro-Volution Group!"
						SendSystemMessage:FireAllClients(msg, Color3.new(1,1,0), 0)
					end
				end)
				
				if not success then
					warn(err)
				end
				Save(plr)
			end
		end
	end
end

local function Leave(plr)
	if game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name) then
		Save(plr)
		game.ReplicatedStorage.StatFile[plr.Name]:Destroy()
		local userId = getUserIdFromUsername(plr.Name)
		if userId then
			if table.find(inviters, userId) then
				table.remove(inviters, table.find(inviters, userId))
			end
		end
	end
end

local function enterCode(plr, code)
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name)
	if game.ReplicatedStorage.Assets.TwitterCodes:FindFirstChild(code) and playerFolder then
		local enteredCodes = playerFolder.TwitterCodes
		if not enteredCodes:FindFirstChild(code) then
			if game.ReplicatedStorage.Assets.TwitterCodes[code].ItemType.Value == 0 then
				local savedCode = Instance.new("Folder")
				savedCode.Name = code
				savedCode.Parent = playerFolder.TwitterCodes
				playerFolder.statnumbers.animalBux.Value = playerFolder.statnumbers.animalBux.Value + game.ReplicatedStorage.Assets.TwitterCodes[code].Quantity.Value
			end
			local msg = "[SYSTEM] " .. plr.Name .. " was rewarded " .. game.ReplicatedStorage.Assets.TwitterCodes[code].Quantity.Value .. " Tokens for entering a code!"
			SendSystemMessage:FireAllClients(msg, Color3.new(1,1,0), 0)
		end
	end
end

local function invitedPlayer(inviter)
	local userId = getUserIdFromUsername(inviter.Name)
	if userId and table.find(inviters, userId) == nil then
		table.insert(inviters, userId)
	end
end

local function Load(plr)
	
	local key = "plr-"..plr.UserId
	
	local savedData
	
	local success, err = pcall(function()
		savedData = DataStore:GetAsync(key)
	end)
	
	if not success then
		warn("Failed to read data "..tostring(err))
		return
	end
	
	local playerFolder = Instance.new("Folder")
	playerFolder.Name = plr.Name
	playerFolder.Parent = game.ReplicatedStorage.StatFile
	
	local stats = Instance.new("Folder")
	stats.Name = "statnumbers"
	stats.Parent = playerFolder
	
	local animalBux = Instance.new("IntValue")
	animalBux.Name = "animalBux"
	animalBux.Parent = stats
	animalBux.Value = 0
	
	local lastRewarded = Instance.new("IntValue")
	lastRewarded.Name = "lastRewarded"
	lastRewarded.Parent = stats
	lastRewarded.Value = 0
	
	local lastInvited = Instance.new("IntValue")
	lastInvited.Name = "lastInvited"
	lastInvited.Parent = stats
	lastInvited.Value = 0
	
	local gaveReferalYet = Instance.new("BoolValue")
	gaveReferalYet.Name = "gaveReferalYet"
	gaveReferalYet.Parent = stats
	gaveReferalYet.Value = false
	
	local streak = Instance.new("IntValue")
	streak.Name = "streak"
	streak.Parent = stats
	streak.Value = -1
	
	local firstTimePlaying = Instance.new("BoolValue")
	firstTimePlaying.Name = "firstTimePlaying"
	firstTimePlaying.Parent = stats
	firstTimePlaying.Value = true
	
	local firstDailyReward = Instance.new("BoolValue")
	firstDailyReward.Name = "firstDailyReward"
	firstDailyReward.Parent = stats
	firstDailyReward.Value = true
	
	local receivedGroupReward = Instance.new("BoolValue")
	receivedGroupReward.Name = "receivedGroupReward"
	receivedGroupReward.Parent = stats
	receivedGroupReward.Value = false
	
		local wins = Instance.new("IntValue")
		wins.Name = "Wins"
		wins.Parent = stats
	
		local kills = Instance.new("IntValue")
		kills.Name = "Kills"
		kills.Parent = stats
	
		local lastEquipped = Instance.new("StringValue")
		lastEquipped.Name = "lastEquipped"
		lastEquipped.Parent = stats
		lastEquipped.Value = "Dog"
	
	local lastEffect = Instance.new("StringValue")
	lastEffect.Name = "lastEffect"
	lastEffect.Parent = stats
	lastEffect.Value = "White Circle"
	
	local lastTrail = Instance.new("StringValue")
	lastTrail.Name = "lastTrail"
	lastTrail.Parent = stats
	lastTrail.Value = "White Dash"
	
	local evolutions = Instance.new("Folder")
	evolutions.Name = "Evolutions"
	evolutions.Parent = playerFolder
	
		local dog = Instance.new("Folder")
		dog.Name = "Dog"
		dog.Parent = evolutions
	
	
	local effects = Instance.new("Folder")
	effects.Name = "Effects"
	effects.Parent = playerFolder
	
		local whiteCircle = Instance.new("Folder")
		whiteCircle.Name = "White Circle"
		whiteCircle.Parent = effects
	
	local trails = Instance.new("Folder")
	trails.Name = "Trails"
	trails.Parent = playerFolder
	
	local whiteTrail = Instance.new("Folder")
	whiteTrail.Name = "White Dash"
	whiteTrail.Parent = trails
	
	local crates = Instance.new("Folder")
	crates.Name = "Crates"
	crates.Parent = playerFolder
	
	local tempStats = Instance.new("Folder")
	tempStats.Name = "playerStats"
	tempStats.Parent = playerFolder
	
		local attack = Instance.new("IntValue")
		attack.Name = "attack"
		attack.Parent = tempStats
	
		local isSprinting = Instance.new("BoolValue")
		isSprinting.Name = "isSprinting"
		isSprinting.Parent = tempStats
	
		local evoLvl = Instance.new("IntValue")
		evoLvl.Name = "evoLvl"
		evoLvl.Parent = tempStats
		evoLvl.Value = 1
	
		local stompLevel = Instance.new("IntValue")
		stompLevel.Name = "stompLevel"
		stompLevel.Parent = tempStats
	
		local isSpawned = Instance.new("BoolValue")
		isSpawned.Name = "isSpawned"
	isSpawned.Parent = tempStats
	
	local lastHit = Instance.new("NumberValue")
	lastHit.Name = "lastHit"
	lastHit.Parent = tempStats
	
		local evoLinePos = Instance.new("IntValue")
		evoLinePos.Name = "evoLinePos"
	evoLinePos.Parent = tempStats
	
	local TwitterCodes = Instance.new("Folder")
	TwitterCodes.Name = "TwitterCodes"
	TwitterCodes.Parent = playerFolder
	
	if marketplaceService:UserOwnsGamePassAsync(plr.UserId, game.ReplicatedStorage.Assets.Gamepasses.VIP.Value) then
		local robots = Instance.new("Folder")
		robots.Name = "Robots"
		robots.Parent = evolutions

		local fusionEffect = Instance.new("Folder")
		fusionEffect.Name = "Fusion Effect"
		fusionEffect.Parent = effects

		local fusionTrail = Instance.new("Folder")
		fusionTrail.Name = "Fusion Dash"
		fusionTrail.Parent = trails
	end
	
	if marketplaceService:UserOwnsGamePassAsync(plr.UserId, game.ReplicatedStorage.Assets.Gamepasses.FrostMonsterPack.Value) then
		local yeti = Instance.new("Folder")
		yeti.Name = "Yeti"
		yeti.Parent = evolutions
	end
	
	if marketplaceService:UserOwnsGamePassAsync(plr.UserId, game.ReplicatedStorage.Assets.Gamepasses.PumpkinMonsterPack.Value) then
		local pumpkin = Instance.new("Folder")
		pumpkin.Name = "Pumpkin"
		pumpkin.Parent = evolutions
	end
	
	if savedData then
		if savedData.statnumbers then
			for i,v in pairs(savedData.statnumbers) do
				if stats:FindFirstChild(i) then
					stats:FindFirstChild(i).Value = v
				end
			end
		end
		
		if savedData.Evolutions then
			for i,v in pairs(savedData.Evolutions) do
				if v ~= "Dog" and v ~= "Yeti" and v ~= "Pumpkin" then
					local evoEntry = Instance.new("Folder")
					evoEntry.Name = v
					evoEntry.Parent = evolutions
				end
			end
		end
		
		
		
		if savedData.Effects then
			for i,v in pairs(savedData.Effects) do
				if v ~= "White Circle" then
					local entry = Instance.new("Folder")
					entry.Name = v
					entry.Parent = effects
				end
			end
		end
	
		if savedData.Trails then
			for i,v in pairs(savedData.Trails) do
				if v ~= "White Dash" then
					local entry = Instance.new("Folder")
					entry.Name = v
					entry.Parent = trails
				end
			end
		end
		
		if savedData.Crates then
			for i,v in pairs(savedData.Crates) do
				local entry = Instance.new("Folder")
				entry.Name = v
				entry.Parent = crates
			end
		end
		
		if savedData.TwitterCodes then
			for i,v in pairs(savedData.TwitterCodes) do
				local entry = Instance.new("Folder")
				entry.Name = v
				entry.Parent = TwitterCodes
			end
		end
	end
	
	if os.time() - lastRewarded.Value >= 86400 then
		streak.Value = streak.Value + 1
		local adjustedStreak = streak.Value % 7
		game.ReplicatedStorage.Events.initiateDailyReward:Fire(plr, adjustedStreak)
	end
	local success, err = pcall(function()
		if receivedGroupReward.Value == false and plr:IsInGroup(8386264) then
			receivedGroupReward.Value = true
			animalBux.Value = animalBux.Value + GROUP_REWARD
			local msg = "[SYSTEM] " .. plr.Name .. " was rewarded 800 Tokens for joining the Ro-Volution Group!"
			SendSystemMessage:FireAllClients(msg, Color3.new(1,1,0), 0)
		end
	end)
	
	if not success then
		warn(err)
	end
	
	if os.time() - lastInvited.Value >= 86400 then
		for i,v in pairs(inviters) do
			if plr:IsFriendsWith(v) then
				lastInvited.Value = os.time()
				local inviterName = getUsernameFromUserId(v)
				if inviterName then
					local inviter = game.Players:FindFirstChild(inviterName)
					if inviter then
						local inviterFolder = game.ReplicatedStorage.StatFile:FindFirstChild(inviterName)
						if inviterFolder then
							inviterFolder.statnumbers.animalBux.Value = inviterFolder.statnumbers.animalBux.Value + 300
							sendNotification:FireClient(inviter, "Reward", "+300 Tokens for inviting a friend!", "http://www.roblox.com/asset/?id=7146905951", 3)
						end
					end
				end
			end
		end
	end
	
	--if plr.FollowUserId and os.time() - lastInvited.Value >= 86400 then
	--	local friendName = getUsernameFromUserId(plr.FollowUserId)
	--	if friendName then
	--		local friendLookUp = game.ReplicatedStorage.StatFile:FindFirstChild(friendName)
	--		if friendLookUp then
	--			friendLookUp.statnumbers.animalBux.Value = friendLookUp.statnumbers.animalBux.Value + FRIEND_INVITE_REWARD
	--			lastInvited.Value = os.time()
	--			local msg = "[SYSTEM] " ..friendName .. " was rewarded " .. FRIEND_INVITE_REWARD .. " Tokens for inviting " .. plr.Name
	--			SendSystemMessage:FireAllClients(msg, Color3.new(1,1,0), 0)
	--		end
	--	end
	--end
end

players.PlayerAdded:Connect(Load)
players.PlayerRemoving:Connect(Leave)

game:BindToClose(function()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        coroutine.wrap(Leave)(plr)
    end
end)

saveEvent.Event:Connect(Save)
autoEvent.Event:Connect(autoSave)

enterTwitterCode.OnServerEvent:Connect(enterCode)
invitedPlayers.OnServerEvent:Connect(invitedPlayer)