local image = script.Parent.Parent.Parent.ImageLabel
local MarketplaceService = game:GetService("MarketplaceService")
local Asset = MarketplaceService:GetProductInfo(image.Gamepass.Value,Enum.InfoType.Product)
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
	MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, image.Gamepass.Value)
end)