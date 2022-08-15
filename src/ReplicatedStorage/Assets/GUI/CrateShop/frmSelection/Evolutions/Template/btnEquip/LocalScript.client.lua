repeat wait() until script.Parent.crate.Value ~= nil

local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local statnumbers = playerFolder.statnumbers
local crates = playerFolder.Crates
local frame = script.Parent.Parent
local remote = game.ReplicatedStorage.Events.equipItem
local bindable = game.ReplicatedStorage.Events.RequestCrateOpen
local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select

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
	["Shadow"] = Color3.new(83/255, 151/255, 203/255),
	["Locked"] = Color3.new(158/255, 158/255, 158/255),
	["LockedShadow"] = Color3.new(121/255, 121/255, 121/255)
}

local function hoverButton(btn)
	SoundService:PlayLocalSound(hover)
	btn.Round.ImageColor3 = buttonColor.Hovered
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
	if crates:FindFirstChild(script.Parent.crate.Value.Name) then
		SoundService:PlayLocalSound(select)
		script.Parent.Parent.Parent.Parent.Parent.Parent.Index.Value = "Locked"
		script.Parent.Parent.Parent.Parent.Parent.Parent.Crate.Visible = true
		script.Parent.Parent.Parent.Parent.Parent.Parent.Crate.Image = crateImages[script.Parent.crate.Value.Name]
		bindable:Fire(script.Parent.crate.Value)
		script.Parent.Parent:Destroy()
	end
end)