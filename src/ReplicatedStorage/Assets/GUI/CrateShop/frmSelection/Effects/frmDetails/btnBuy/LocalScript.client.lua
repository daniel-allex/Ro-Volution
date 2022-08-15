repeat wait() until script.Parent.crate.Value ~= nil

local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local statnumbers = playerFolder.statnumbers
local frame = script.Parent.Parent.Parent
local bindable = game.ReplicatedStorage.Events.RequestCrateOpen
local buyCrate = game.ReplicatedStorage.Events.buyCrate
local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select
local success = Audio.Purchase
local fail = Audio.Fail
local specialMode = script.Parent.Parent.Parent.Parent.Parent.specialMode
local purchaseDebounce = false

local crateImages = {
	["Wood Crate"] = "http://www.roblox.com/asset/?id=6086919958",
	["Stone Crate"] = "http://www.roblox.com/asset/?id=6237984809",
	["Gold Crate"] = "http://www.roblox.com/asset/?id=6087067091",
	["Iron Crate"] = "http://www.roblox.com/asset/?id=6732420336",
	["Diamond Crate"] = "http://www.roblox.com/asset/?id=6086918999",
	["Ruby Crate"] = "http://www.roblox.com/asset/?id=6732419857"
}

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(66/255, 165/255, 245/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255),
	["UnselectedSpecial"] = Color3.new(253/255, 216/255, 53/255),
	["SelectedSpecial"] = Color3.new(251/255, 192/255, 45/255),
	["SpecialShadow"] = Color3.new(212/255, 179/255, 44/255),
	["SpecialSelectedShadow"] = Color3.new(203/255, 153/255, 35/255),
	["Shadow"] = Color3.new(83/255, 151/255, 203/255),
	["Locked"] = Color3.new(158/255, 158/255, 158/255),
	["LockedShadow"] = Color3.new(121/255, 121/255, 121/255),
	["Success"] = Color3.new(102/255, 187/255, 106/255),
	["Fail"] = Color3.new(239/255, 83/255, 80/255),
	["SuccessShadow"] = Color3.new(0.32549, 0.596078, 0.333333),
	["FailShadow"] = Color3.new(0.701961, 0.239216, 0.231373)
}

local function hoverButton(btn)
	SoundService:PlayLocalSound(hover)
	if purchaseDebounce == false then
		if specialMode.Value then
			btn.Round.ImageColor3 = buttonColor.SelectedSpecial
			btn.imgShadow.ImageColor3 = buttonColor.SpecialSelectedShadow
			script.Parent.txtBuy.Text = "Buy"
			script.Parent.txtBuy.txtShadow.Text = "Buy"
		else
			btn.Round.ImageColor3 = buttonColor.Hovered
			btn.imgShadow.ImageColor3 = buttonColor.SelectedShadow
			script.Parent.txtBuy.Text = "Buy"
			script.Parent.txtBuy.txtShadow.Text = "Buy"
		end
	end
end

local function unhoverButton(btn)
	if purchaseDebounce == false then
		if specialMode.Value then
			btn.Round.ImageColor3 = buttonColor.UnselectedSpecial
			btn.imgShadow.ImageColor3 = buttonColor.SpecialShadow
			script.Parent.txtBuy.Text = "Buy"
			script.Parent.txtBuy.txtShadow.Text = "Buy"
		else
			btn.Round.ImageColor3 = buttonColor.Unselected
			btn.imgShadow.ImageColor3 = buttonColor.Shadow
			script.Parent.txtBuy.Text = "Buy"
			script.Parent.txtBuy.txtShadow.Text = "Buy"
		end
	end
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent)
end)

script.Parent.MouseButton1Click:Connect(function()
	if purchaseDebounce == false then
		purchaseDebounce = true
		if statnumbers.animalBux.Value >= script.Parent.crate.Value.Data.Price.Value then
			purchaseDebounce = true
			SoundService:PlayLocalSound(success)
			buyCrate:FireServer(script.Parent.crate.Value)
			script.Parent.Round.ImageColor3 = buttonColor.Success
			script.Parent.imgShadow.ImageColor3 = buttonColor.SuccessShadow
			script.Parent.txtBuy.Text = "Purchased"
			script.Parent.txtBuy.txtShadow.Text = "Purchased"
			wait(0.5)
			purchaseDebounce = false
			unhoverButton(script.Parent)
		else
			SoundService:PlayLocalSound(fail)
			script.Parent.Round.ImageColor3 = buttonColor.Fail
			script.Parent.imgShadow.ImageColor3 = buttonColor.FailShadow
			script.Parent.txtBuy.Text = "Failed"
			script.Parent.txtBuy.txtShadow.Text = "Failed"
			wait(0.5)
			purchaseDebounce = false
			unhoverButton(script.Parent)
		end
	end
end)

if specialMode.Value then
	if script.Parent.Parent.Parent.selectedCrate.Value ~= nil then
		if statnumbers.animalBux.Value >= script.Parent.Parent.Parent.selectedCrate.Value.Data.Price.Value then
			script.Parent.Round.ImageColor3 = buttonColor.UnselectedSpecial
			script.Parent.imgShadow.ImageColor3 = buttonColor.SpecialShadow
		end
	end
end

specialMode.Changed:Connect(function()
	if script.Parent.Parent.Parent.selectedCrate.Value ~= nil then
		if specialMode.Value and statnumbers.animalBux.Value >= script.Parent.Parent.Parent.selectedCrate.Value.Data.Price.Value then
			script.Parent.Round.ImageColor3 = buttonColor.UnselectedSpecial
			script.Parent.imgShadow.ImageColor3 = buttonColor.SpecialShadow
		else
			script.Parent.Round.ImageColor3 = buttonColor.Unselected
			script.Parent.imgShadow.ImageColor3 = buttonColor.Shadow
		end
	end
end)