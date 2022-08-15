local Round = game.ReplicatedStorage.RoundStatus:WaitForChild("inRound")
local Snow = game.Lighting:WaitForChild("Snow")
local Original = game.Lighting:WaitForChild("Original")
local color = game.Lighting:WaitForChild("IceMap")
local OriginalValue1 = game.Lighting:WaitForChild("1")
local OriginalValue2 = game.Lighting:WaitForChild("2")
local IceValue1 = game.Lighting:WaitForChild("3")
local IceValue2 = game.Lighting:WaitForChild("4")

Round.changed:Connect(function()

if Round.Value == true then 
	if game.Workspace.Map.aaaaa.Value.Value == 1 then
		game.Lighting.FogColor = Snow.Value
		game.Lighting.FogEnd = IceValue1.Value
		game.Lighting.FogStart = IceValue2.Value
		color.Enabled = true
	end
else
	game.Lighting.FogColor = Original.Value
	game.Lighting.FogEnd = OriginalValue1.Value
	game.Lighting.FogStart = OriginalValue2.Value
	
end
end)

