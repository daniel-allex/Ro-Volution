local SoundService = game:GetService("SoundService")
local currentSelected = script.Parent.Selected
local Selection = script.Parent.Selection
local frmSelection = script.Parent.Parent.frmSelection
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["Hovered"] = Color3.new(66/255, 165/255, 245/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255)
}

Selection.Effects.MouseButton1Click:Connect(function()
	currentSelected.Value = Selection.Effects.Name
end)

Selection.Evolutions.MouseButton1Click:Connect(function()
	currentSelected.Value = Selection.Evolutions.Name
end)

Selection.Trails.MouseButton1Click:Connect(function()
	currentSelected.Value = Selection.Trails.Name
end)

local function selectButton(btn)
	btn.Round.ImageColor3 = buttonColor.Selected
	btn.imgShadow.ImageTransparency = 0
	SoundService:PlayLocalSound(select)
	
	for i,v in pairs(Selection:GetChildren()) do
		if v.Name ~= btn.Name then
			v.Round.ImageColor3 = buttonColor.Unselected
			v.imgShadow.ImageTransparency = 1
		end
	end
	
	for i,v in pairs(frmSelection:GetChildren()) do
		if v.Name ~= btn.Name then
			v.Visible = false
		end
	end
	
	frmSelection[btn.Name].Visible = true
end

local function hoverButton(btn)
	if btn.Name ~= currentSelected.Value then
		btn.Round.ImageColor3 = buttonColor.Hovered
		SoundService:PlayLocalSound(hover)
	end
end

local function unhoverButton(btn)
	if btn.Name ~= currentSelected.Value then
		btn.Round.ImageColor3 = buttonColor.Unselected
	end
end

currentSelected.Changed:Connect(function()
	selectButton(Selection[currentSelected.Value])
end)

Selection.Trails.MouseEnter:Connect(function()
	hoverButton(Selection.Trails)
end)

Selection.Trails.MouseLeave:Connect(function()
	unhoverButton(Selection.Trails)
end)

Selection.Evolutions.MouseEnter:Connect(function()
	hoverButton(Selection.Evolutions)
end)

Selection.Evolutions.MouseLeave:Connect(function()
	unhoverButton(Selection.Evolutions)
end)

Selection.Effects.MouseEnter:Connect(function()
	hoverButton(Selection.Effects)
end)

Selection.Effects.MouseLeave:Connect(function()
	unhoverButton(Selection.Effects)
end)