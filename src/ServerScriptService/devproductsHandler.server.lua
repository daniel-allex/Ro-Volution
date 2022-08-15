local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game.ReplicatedStorage
local StatFile = ReplicatedStorage.StatFile
local Save = ReplicatedStorage.Events.Save
local getTokenRain = ReplicatedStorage.Events.getTokenRain
local SendSystemMessage = ReplicatedStorage.Events.SendSystemMessage
local Devproducts = ReplicatedStorage.Assets.Devproducts
local Gamepasses = ReplicatedStorage.Assets.Gamepasses
local chatColor = BrickColor.new("New Yeller")
local coinRainQueue = {}
local coinRainEvent = ReplicatedStorage.Events.CoinRainEvent

-- Data store for tracking purchases that were successfully processed
local purchaseHistoryStore = DataStoreService:GetDataStore("PurchaseHistory")

-- Table setup containing product IDs and functions for handling purchases
local productFunctions = {}


-- 550AB
productFunctions[Devproducts["550AB"].ID.Value] = function(receipt, player)
	local playerFolder = StatFile[player.Name]
	local animalBux = playerFolder.statnumbers.animalBux
	if animalBux then
		animalBux.Value = animalBux.Value + Devproducts["550AB"].AnimalBux.Value
		Save:Fire(player)
		-- Indicate a successful purchase
		return true
	end
end

-- 1200AB
productFunctions[Devproducts["1200AB"].ID.Value] = function(receipt, player)
	local playerFolder = StatFile[player.Name]
	local animalBux = playerFolder.statnumbers.animalBux
	if animalBux then
		animalBux.Value = animalBux.Value + Devproducts["1200AB"].AnimalBux.Value
		Save:Fire(player)
		-- Indicate a successful purchase
		return true
	end
end

-- 2600AB
productFunctions[Devproducts["2600AB"].ID.Value] = function(receipt, player)
	local playerFolder = StatFile[player.Name]
	local animalBux = playerFolder.statnumbers.animalBux
	if animalBux then
		animalBux.Value = animalBux.Value + Devproducts["2600AB"].AnimalBux.Value
		Save:Fire(player)
		-- Indicate a successful purchase
		return true
	end
end

-- 7000AB
productFunctions[Devproducts["7000AB"].ID.Value] = function(receipt, player)
	local playerFolder = StatFile[player.Name]
	local animalBux = playerFolder.statnumbers.animalBux
	if animalBux then
		animalBux.Value = animalBux.Value + Devproducts["7000AB"].AnimalBux.Value
		Save:Fire(player)
		-- Indicate a successful purchase
		return true
	end
end

-- 15500AB
productFunctions[Devproducts["15500AB"].ID.Value] = function(receipt, player)
	local playerFolder = StatFile[player.Name]
	local animalBux = playerFolder.statnumbers.animalBux
	if animalBux then
		animalBux.Value = animalBux.Value + Devproducts["15500AB"].AnimalBux.Value
		Save:Fire(player)
		-- Indicate a successful purchase
		return true
	end
end

-- Coin Rain
productFunctions[Gamepasses["AnimalBuxRain"].Value] = function(receipt, player)
	table.insert(coinRainQueue, player)
	local msg
	if #coinRainQueue == 1 then
		msg = "[SYSTEM] " .. player.Name .. " has purchased the Token Rain for next round (" .. #coinRainQueue.."/" .. #coinRainQueue .. ")"
	else
		msg = "[SYSTEM] " .. player.Name .. " has purchased the Token Rain for a later round (" .. #coinRainQueue.."/" .. #coinRainQueue .. ")"
	end
	SendSystemMessage:FireAllClients(msg, Color3.new(1,1,0))
	-- Indicate a successful purchase
	return true
end
local whiteList = {11742256, 11816529, 138777139, 2861361, 2755588326} -- previously banned players

-- The core 'ProcessReceipt' callback function
local function processReceipt(receiptInfo)

	-- Determine if the product was already granted by checking the data store  
	local playerProductKey = receiptInfo.PlayerId .. "_" .. receiptInfo.PurchaseId
	local purchased = false
	local success, errorMessage = pcall(function()
		purchased = purchaseHistoryStore:GetAsync(playerProductKey)
	end)
	-- If purchase was recorded, the product was already granted
	if success and purchased then
		
		return Enum.ProductPurchaseDecision.PurchaseGranted
	elseif not success then
		error("Data store error:" .. errorMessage)
	end

	-- Find the player who made the purchase in the server
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		-- The player probably left the game
		-- If they come back, the callback will be called again
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	-- Look up handler function from 'productFunctions' table above
	local handler = productFunctions[receiptInfo.ProductId]

	-- Call the handler function and catch any errors
	local success, result = pcall(handler, receiptInfo, player)
	if not success or not result then
		warn("Error occurred while processing a product purchase")
		print("\nProductId:", receiptInfo.ProductId)
		print("\nPlayer:", player)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	-- Record transaction in data store so it isn't granted again
	local success, errorMessage = pcall(function()
		purchaseHistoryStore:SetAsync(playerProductKey, true)
	end)
	if not success then
		error("Cannot save purchase data: " .. errorMessage)
	end

	-- IMPORTANT: Tell Roblox that the game successfully handled the purchase
	return Enum.ProductPurchaseDecision.PurchaseGranted
end


local function receiveTokenRain(plr)
	if table.find(whiteList, plr.UserId) ~= nil then
		table.insert(coinRainQueue, plr)
		local msg
		if #coinRainQueue == 1 then
			msg = "[SYSTEM] " .. plr.Name .. " has purchased the Token Rain for next round (" .. #coinRainQueue.."/" .. #coinRainQueue .. ")"
		else
			msg = "[SYSTEM] " .. plr.Name .. " has purchased the Token Rain for a later round (" .. #coinRainQueue.."/" .. #coinRainQueue .. ")"
		end
		SendSystemMessage:FireAllClients(msg, Color3.new(1,1,0), 0)
	end
end

getTokenRain.OnServerEvent:Connect(receiveTokenRain)

-- Set the callback; this can only be done once by one script on the server! 
MarketplaceService.ProcessReceipt = processReceipt

ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	if ReplicatedStorage.RoundStatus.inRound.Value then
		if #coinRainQueue > 0 then
			SendSystemMessage:FireAllClients("[SYSTEM] Thanks to " .. coinRainQueue[1].Name .. ", Tokens will fall from the sky during the round!", Color3.new(1,1,0), 0)
			table.remove(coinRainQueue, 1)
			coinRainEvent:Fire()
		end
	end
end)