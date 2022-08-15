local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local statnumbers = playerFolder.statnumbers
local remote = game.ReplicatedStorage.Events.purchaseEvo

script.Parent.MouseButton1Click:Connect(function()
	if statnumbers.animalBux.Value > game.ReplicatedStorage.EvolutionLines[script.Parent.evoLine.Value].intPrice.Value then
		remote:FireServer(script.Parent.evoLine.Value)
	end
end)