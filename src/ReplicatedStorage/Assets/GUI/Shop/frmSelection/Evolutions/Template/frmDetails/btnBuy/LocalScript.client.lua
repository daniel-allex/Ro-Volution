repeat wait() until script.Parent.Gamepass.Value ~= nil

local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local statnumbers = playerFolder.statnumbers
local frame = script.Parent.Parent.Parent
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select
local owned = false

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(66/255, 165/255, 245/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255),
	["Shadow"] = Color3.new(83/255, 151/255, 203/255),
	["Locked"] = Color3.new(158/255, 158/255, 158/255),
	["LockedShadow"] = Color3.new(121/255, 121/255, 121/255)
}

local function checkOwnership()
	if MarketplaceService:UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, script.Parent.Gamepass.Value) then
		script.Parent.txtBuy.Text = "Owned"
		script.Parent.txtBuy.txtShadow.Text = "Owned"
		owned = true
		return true
	end
	return false
end

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
	SoundService:PlayLocalSound(select)
	if owned == false or script.Parent.IsGamepass.Value == false then
		if script.Parent.IsGamepass.Value == true then
			owned = checkOwnership()
		end
		if script.Parent.IsGamepass.Value == false then
			MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, script.Parent.Gamepass.Value)
		elseif owned == false then
			MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, script.Parent.Gamepass.Value)
		end
	end
end)

if script.Parent.IsGamepass.Value == true then
	checkOwnership()
end