local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Hovered"] = Color3.new(245/255, 245/255, 245/255),
	["Unselected"] = Color3.new(1, 1, 1),
	["Shadow"] = Color3.new(189/255, 189/255, 189/255),
}

local function hoverButton(btn)
	script.Parent.Image = "http://www.roblox.com/asset/?id=2272085992"
	SoundService:PlayLocalSound(hover)
end

local function unhoverButton(btn)
	script.Parent.Image = "http://www.roblox.com/asset/?id=2272085507"
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent)
end)

script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Parent.Parent.Index.Value = "devproducts"
	SoundService:PlayLocalSound(select)
end)