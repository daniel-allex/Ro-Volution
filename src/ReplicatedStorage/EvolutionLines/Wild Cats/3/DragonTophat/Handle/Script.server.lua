local replicatedStorage = game:GetService("ReplicatedStorage")
repeat wait() until script.Parent.Parent.Parent.Parent.Name ~= "ReplicatedStorage"
local playerName = script.Parent.Parent.Parent.Name
local playerFolder = replicatedStorage.StatFile:FindFirstChild(playerName)

if playerFolder then
	local evoLvl = playerFolder.playerStats.evoLvl
	script.Parent.Mesh.Offset = Vector3.new(0, (-8/65) * evoLvl.Value - (33/13), (-9/260) * evoLvl.Value + (6/65))
	
	evoLvl.Changed:Connect(function()
		script.Parent.Mesh.Offset = Vector3.new(0, (-8/65) * evoLvl.Value - (33/13), (-9/260) * evoLvl.Value + (6/65))
	end)
end