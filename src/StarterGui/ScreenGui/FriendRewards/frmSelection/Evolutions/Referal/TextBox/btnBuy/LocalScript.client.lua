repeat wait() until script.Parent.Gamepass.Value ~= nil

local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local statnumbers = playerFolder.statnumbers
local frame = script.Parent.Parent.Parent
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local referFriendEvent = game.ReplicatedStorage.Events.referFriend
local hover = Audio.Hover
local fail = Audio.Fail
local select = Audio.Select
local players = game:GetService("Players")
local owned = false

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

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(66/255, 165/255, 245/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255),
	["Shadow"] = Color3.new(83/255, 151/255, 203/255),
	["Locked"] = Color3.new(158/255, 158/255, 158/255),
	["LockedShadow"] = Color3.new(121/255, 121/255, 121/255)
}

local function hoverButton(btn)
	btn.Round.ImageColor3 = buttonColor.Hovered
	SoundService:PlayLocalSound(hover)
end

local function unhoverButton(btn)
	btn.Round.ImageColor3 = buttonColor.Unselected
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent)
end)

script.Parent.MouseButton1Click:Connect(function()
	local playerName = script.Parent.Parent.Text
	if getUserIdFromUsername(playerName) then
		if statnumbers.gaveReferalYet.Value == false then
			SoundService:PlayLocalSound(select)
			referFriendEvent:FireServer(playerName)
		else
			SoundService:PlayLocalSound(fail)
		end
	else
		SoundService:PlayLocalSound(fail)
	end
end)