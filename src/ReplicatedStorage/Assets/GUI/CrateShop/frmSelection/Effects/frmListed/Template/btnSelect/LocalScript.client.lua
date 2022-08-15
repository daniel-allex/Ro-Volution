local frame = script.Parent.Parent.Parent
local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select
local selected = script.Parent.Parent.Parent.Parent.selectedCrate
local crate = script.Parent.Parent.ViewportFrame.objAnimal

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(245/255, 245/255, 245/255),
	["Unselected"] = Color3.new(1, 1, 1),
	["Shadow"] = Color3.new(189/255, 189/255, 189/255),
}

local function hoverButton(btn)
	btn.Parent.BackgroundColor3 = buttonColor.Hovered
	btn.Parent.ViewportFrame.BackgroundColor3 = buttonColor.Hovered
	SoundService:PlayLocalSound(hover)
end

local function unhoverButton(btn)
	btn.Parent.BackgroundColor3 = buttonColor.Unselected
	btn.Parent.ViewportFrame.BackgroundColor3 = buttonColor.Unselected

end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent)
end)

script.Parent.MouseButton1Click:Connect(function()
	selected.Value = crate.Value
	SoundService:PlayLocalSound(select)
end)