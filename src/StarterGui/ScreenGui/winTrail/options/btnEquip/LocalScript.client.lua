local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local remote = game.ReplicatedStorage.Events.equipItem
local hover = Audio.Hover
local select = Audio.Select

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(66/255, 165/255, 245/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255),
	["Shadow"] = Color3.new(83/255, 151/255, 203/255)
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
	remote:FireServer("Trail", script.Parent.evoLine.Value)
	script.Parent.Parent.Parent.Parent.Index.Value = "Home"
	SoundService:PlayLocalSound(select)
	script.Parent.Parent.Parent:Destroy()

end)