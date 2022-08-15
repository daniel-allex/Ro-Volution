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
	["Unselected"] = Color3.new(100/255, 181/255, 246/255),
	["Special"] = Color3.new(253/255, 216/255, 53/255),
	["SelectedSpecial"] = Color3.new(251/255, 192/255, 45/255),
	["SpecialShadow"] = Color3.new(212/255, 179/255, 44/255),
	["Shadow"] = Color3.new(22/255, 101/255, 171/255)
}

Selection.Effects.MouseButton1Click:Connect(function()
	currentSelected.Value = Selection.Effects.Name
end)

Selection.Evolutions.MouseButton1Click:Connect(function()
	currentSelected.Value = Selection.Evolutions.Name
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
	
	if btn.Name == "Effects" or #(script.Parent.Parent.frmSelection.Evolutions:GetChildren()) > 3 then
		script.Parent.Parent.NoCratesLabel.Visible = false
	else
		script.Parent.Parent.NoCratesLabel.Visible = true
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

if script.Parent.Parent.specialMode.Value == true then
	Selection.Effects.txtHeader.TextColor3 = buttonColor.Special
end

script.Parent.Parent.specialMode.Changed:Connect(function()
	if script.Parent.Parent.specialMode.Value == true then
		Selection.Effects.txtHeader.TextColor3 = buttonColor.Special
	else
		Selection.Effects.txtHeader.TextColor3 = Color3.new(1,1,1)
	end
end)