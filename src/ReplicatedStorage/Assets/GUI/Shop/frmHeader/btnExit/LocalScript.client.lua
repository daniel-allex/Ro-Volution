local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(229/255, 57/255, 53/255),
	["Unselected"] = Color3.new(229/255, 115/255, 115/255),
	["Shadow"] = Color3.new(189/255, 189/255, 189/255),
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
	script.Parent.Parent.Parent.Parent.Index.Value = "Home"
	SoundService:PlayLocalSound(select)
end)