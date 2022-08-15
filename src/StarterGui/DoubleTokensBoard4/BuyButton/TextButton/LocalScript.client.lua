local image = script.Parent.Parent.Parent.ImageLabel
local MarketplaceService = game:GetService("MarketplaceService")
local Asset = MarketplaceService:GetProductInfo(image.Gamepass.Value,Enum.InfoType.GamePass)
image.Image = "rbxassetid://"..Asset.IconImageAssetId

local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select
local owned = false

local buttonColor = {
	["Hovered"] = Color3.new(0.341176, 0.623529, 0.34902),
	["Unselected"] = Color3.new(102/255, 187/255, 106/255),
}

local function checkOwnership()
	if MarketplaceService:UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, image.Gamepass.Value) then
		script.Parent.Parent.text.Visible = false
		script.Parent.Parent.imgCurrency.Visible = false
		script.Parent.Parent.owned.Visible = true
		owned = true
		return true
	end
	return false
end

local function hoverButton()
	script.Parent.Parent.BackgroundColor3 = buttonColor.Hovered
	SoundService:PlayLocalSound(hover)
end

local function unhoverButton()
	script.Parent.Parent.BackgroundColor3 = buttonColor.Unselected
end

script.Parent.MouseEnter:Connect(function()
	hoverButton()
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton()
end)

script.Parent.MouseButton1Click:Connect(function()
	SoundService:PlayLocalSound(select)
	if owned == false then
		local owned = checkOwnership()
		if not owned then
			MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, image.Gamepass.Value)
		end
	end
end)

checkOwnership()
