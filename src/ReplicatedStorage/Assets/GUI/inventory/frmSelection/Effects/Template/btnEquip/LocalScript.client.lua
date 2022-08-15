repeat wait() until script.Parent.effect.Value ~= nil

local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local MarketplaceService = game:GetService("MarketplaceService")
local statnumbers = playerFolder.statnumbers
local frame = script.Parent.Parent
local remote = game.ReplicatedStorage.Events.equipItem
local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select

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
	if btn.Status.Value ~= "Locked" and btn.Status.Value ~= "Equipped" then
		SoundService:PlayLocalSound(hover)
		btn.Round.ImageColor3 = buttonColor.Hovered
	end
end

local function unhoverButton(btn)
	if btn.Status.Value ~= "Locked" and btn.Status.Value ~= "Equipped" then
		btn.Round.ImageColor3 = buttonColor.Unselected
	end
end

local function lockButton(btn)
	btn.Status.Value = "Locked"
	btn.Round.ImageColor3 = buttonColor.Locked
	btn.imgShadow.ImageColor3 = buttonColor.LockedShadow
end

local function unlockButton(btn)
	btn.Status.Value = "Unequipped"
	btn.txtBuy.Text = "Equip"
	btn.txtBuy.txtShadow.Text = "Equip"
	btn.Round.ImageColor3 = buttonColor.Unselected
	btn.imgShadow.ImageColor3 = buttonColor.Shadow
end

local function equip(btn)
	btn.Status.Value = "Equipped"
	btn.txtBuy.Text = "Unequip"
	btn.txtBuy.txtShadow.Text = "Unequip"
	if script.Parent.effect.Value == "White Circle" then
		btn.txtBuy.Text = "Equipped"
		btn.txtBuy.txtShadow.Text = "Equipped"
	end
	btn.Round.ImageColor3 = buttonColor.Selected
	btn.imgShadow.ImageColor3 = buttonColor.SelectedShadow
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent)
end)

if script.Parent.effect.Value == statnumbers.lastEffect.Value then
	unlockButton(script.Parent)
	equip(script.Parent)
elseif script.Parent.Status.Value ~= "Locked" and script.Parent.Status.Value ~= "Buy" then
	unlockButton(script.Parent)
end

script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Status.Value == "Buy" then
		MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, script.Parent.Gamepass.Value)
		SoundService:PlayLocalSound(select)
	elseif script.Parent.Status.Value ~= "Locked" and playerFolder.Effects:FindFirstChild(script.Parent.effect.Value) then
		remote:FireServer("Effect", script.Parent.effect.Value)
		SoundService:PlayLocalSound(select)
	end
end)

statnumbers.lastEffect.Changed:Connect(function()
	if script.Parent.effect.Value == statnumbers.lastEffect.Value then
		unlockButton(script.Parent)
		equip(script.Parent)
	elseif script.Parent.Status.Value ~= "Locked" and script.Parent.Status.Value ~= "Buy" then
		unlockButton(script.Parent)
	end
end)

playerFolder.Effects.ChildAdded:Connect(function(item)
	print("New Effect: " .. item.Name)
	repeat wait() until item.Name ~= "Folder"
	if item.Name == script.Parent.effect.Value then
		if item.Name ~= statnumbers.lastEffect.Value then
			frame.Name = "0" ..string.sub(frame.Name, 2)
			unlockButton(script.Parent)
		else
			frame.Name = "0"..string.sub(frame.Name, 2)
			equip(script.Parent)
		end
	end
end)