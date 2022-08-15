local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local statnumbers = playerFolder.statnumbers

script.Parent.Text = statnumbers.animalBux.Value

statnumbers.animalBux.Changed:Connect(function()
	script.Parent.Text = statnumbers.animalBux.Value
end)