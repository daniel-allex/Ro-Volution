local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["Hovered"] = Color3.new(66/255, 165/255, 245/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255)
}

local function hoverButton(btn)
	if btn.Status.Value ~= "Locked" then
		btn.Round.ImageColor3 = buttonColor.Hovered
	end
end

local function unhoverButton(btn)
	if btn.Status.Value ~= "Locked" then
		btn.Round.ImageColor3 = buttonColor.Unselected
	end
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent)
end)