local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select
local index = script.Parent.Parent.Parent.Parent.Index

local function hoverButton(btn)
	btn.imgBackground.Image = "http://www.roblox.com/asset/?id=6312884157"
	SoundService:PlayLocalSound(hover)
end

local function unhoverButton(btn)
	btn.imgBackground.Image = "http://www.roblox.com/asset/?id=6312881673"
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent.Parent)
end)

script.Parent.MouseButton1Click:Connect(function()
	if index.Value ~= "Locked" then
		if index.Value == "inventory" then
			index.Value = "Home"
		else
			index.Value = "inventory"

		end
	end
	
	SoundService:PlayLocalSound(select)

end)