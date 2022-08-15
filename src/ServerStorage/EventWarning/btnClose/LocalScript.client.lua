local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select

local buttonColor = {
	["Hovered"] = Color3.new(0.866667, 0.376471, 0.227451),
	["Unselected"] = Color3.new(255/255, 112/255, 67/255),
	["Shadow"] = Color3.new(197/255, 85/255, 51/255),
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
	script.Parent.Parent.Parent.Index.Value = "Home"
	SoundService:PlayLocalSound(select)
	script.Parent.Parent:Destroy()

end)