local replicatedStorage = game:GetService("ReplicatedStorage")
repeat wait() until script.Parent.Parent.Parent.Parent.Name ~= "ReplicatedStorage"
local playerName = script.Parent.Parent.Parent.Name
local playerFolder = replicatedStorage.StatFile:FindFirstChild(playerName)

if playerFolder then
	local evoLvl = playerFolder.playerStats.evoLvl
	script.Parent.SpecialMesh.Offset = Vector3.new(0, (-1/30) * evoLvl.Value - (3/5), (-1/12) * evoLvl.Value - (1/2))
	
	evoLvl.Changed:Connect(function()
		script.Parent.SpecialMesh.Offset = Vector3.new(0, (-1/30) * evoLvl.Value - (3/5), (-1/12) * evoLvl.Value - (1/2))
	end)
end