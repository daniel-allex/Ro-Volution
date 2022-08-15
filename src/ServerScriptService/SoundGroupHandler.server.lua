local SoundService = game:GetService("SoundService")

-- Sound groups
local music = Instance.new("SoundGroup", SoundService)
local soundEffects = Instance.new("SoundGroup", SoundService)

-- not sure how we would toggle music given it's being played globally, but in the future ig?
game.Players.PlayerAdded:Connect(function(player)
	
end)

game.Players.PlayerRemoving:Connect(function(player)
	
end)


