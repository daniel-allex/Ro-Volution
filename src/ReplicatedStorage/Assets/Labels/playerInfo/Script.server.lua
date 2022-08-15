repeat wait() until script.Parent.Name ~= "Labels"
local character = script.Parent.Parent.Parent
local playerName = character.Name
local replicatedStorage = game.ReplicatedStorage
local StatFile = replicatedStorage.StatFile
local playerFolder = StatFile:FindFirstChild(playerName)
local SIZE_PER_EVO = 0.3
local MAX_HEALTH = Color3.new(67/255, 160/255, 71/255)
local MID_HEALTH = Color3.new(255/255, 235/255, 59/255)
local MIN_HEALTH = Color3.new(198/255, 40/255, 40/255)
local evoLvl = 0

if playerFolder then
	evoLvl = playerFolder.playerStats.evoLvl
end

local function getMaxHeight()
	local maxHeight = character.Head.Position.Y + 0.5 * character.Head.Size.Y

	local headMesh = character.Head:FindFirstChild("Mesh")
	if not headMesh then
		headMesh = character.Head:FindFirstChild("SpecialMesh")
		if headMesh then
			maxHeight = math.max(maxHeight, character.Head.Position.Y + headMesh.Offset.Y + 0.5 * headMesh.Scale.Y)
		end
	end

	for i,v in pairs(character.Humanoid:GetAccessories()) do
		local mesh = v.Handle:FindFirstChild("Mesh")
		if not mesh then
			mesh = v.Handle:FindFirstChild("SpecialMesh")
			if mesh then
				maxHeight = math.max(maxHeight, v.Handle.Position.Y + mesh.Offset.Y + 0.5 * mesh.Scale.Y, v.Handle.Position.Y + 0.5 * mesh.Scale.Y)
			end
		end
	end
	
	return maxHeight
end

script.Parent.StudsOffset = Vector3.new(0, getMaxHeight() + SIZE_PER_EVO * evoLvl.Value - (character.Head.Position.Y + 0.5 * character.Head.Size.Y) + 2 + 0.265 * evoLvl.Value + 0.735, 0)
script.Parent.Size = UDim2.new(0.53 * evoLvl.Value + 1.47, 0, 0.53 * evoLvl.Value + 1.47, 0)
script.Parent.txtEvoLvl.Text = evoLvl.Value
script.Parent.txtEvoLvl.txtShadow.Text = evoLvl.Value

evoLvl.Changed:Connect(function()
	script.Parent.StudsOffset = Vector3.new(0, getMaxHeight() + SIZE_PER_EVO * evoLvl.Value - (character.Head.Position.Y + 0.5 * character.Head.Size.Y) + 2 + 0.265 * evoLvl.Value + 0.735, 0)
	script.Parent.Size = UDim2.new(0.53 * evoLvl.Value + 1.47, 0, 0.53 * evoLvl.Value + 1.47, 0)
	script.Parent.txtEvoLvl.Text = evoLvl.Value
	script.Parent.txtEvoLvl.txtShadow.Text = evoLvl.Value
end)

script.Parent.frmHealth.Bar.Size = UDim2.new(character.Humanoid.Health / character.Humanoid.MaxHealth, 0, 1, 0)
if character.Humanoid.Health / character.Humanoid.MaxHealth >= 0.5 then
	script.Parent.frmHealth.Bar.BackgroundColor3 = MID_HEALTH:lerp(MAX_HEALTH, ((character.Humanoid.Health / character.Humanoid.MaxHealth) - 0.5) * 2)
else
	script.Parent.frmHealth.Bar.BackgroundColor3 = MIN_HEALTH:lerp(MID_HEALTH, (character.Humanoid.Health / character.Humanoid.MaxHealth) * 2)
end

character.Humanoid.Changed:Connect(function()
	script.Parent.frmHealth.Bar.Size = UDim2.new(character.Humanoid.Health / character.Humanoid.MaxHealth, 0, 1, 0)
	if character.Humanoid.Health / character.Humanoid.MaxHealth >= 0.5 then
		script.Parent.frmHealth.Bar.BackgroundColor3 = MID_HEALTH:lerp(MAX_HEALTH, ((character.Humanoid.Health / character.Humanoid.MaxHealth) - 0.5) * 2)
	else
		script.Parent.frmHealth.Bar.BackgroundColor3 = MIN_HEALTH:lerp(MID_HEALTH, (character.Humanoid.Health / character.Humanoid.MaxHealth) * 2)
	end
end)

script.Parent.txtName.Text = playerName
script.Parent.txtName.txtShadow.Text = playerName