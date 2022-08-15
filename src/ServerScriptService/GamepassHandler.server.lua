local MarketplaceService =  game:GetService("MarketplaceService")

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, pass_id, was_purchased)
	if was_purchased and pass_id == game.ReplicatedStorage.Assets.Gamepasses.VIP.Value then
		local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(player.Name)
		if playerFolder then
			local robots = Instance.new("Folder")
			robots.Name = "Robots"
			robots.Parent = playerFolder.Evolutions
			
			local fusionEffect = Instance.new("Folder")
			fusionEffect.Name = "Fusion Effect"
			fusionEffect.Parent = playerFolder.Effects
			
			local fusionTrail = Instance.new("Folder")
			fusionTrail.Name = "Fusion Dash"
			fusionTrail.Parent = playerFolder.Trails
		end
	elseif was_purchased and pass_id == game.ReplicatedStorage.Assets.Gamepasses.FrostMonsterPack.Value then
		local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(player.Name)
		if playerFolder then
			local yeti = Instance.new("Folder")
			yeti.Name = "Yeti"
			yeti.Parent = playerFolder.Evolutions
		end
	elseif was_purchased and pass_id == game.ReplicatedStorage.Assets.Gamepasses.PumpkinMonsterPack.Value then
		local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(player.Name)
		if playerFolder then
			local pumpkin = Instance.new("Folder")
			pumpkin.Name = "Pumpkin"
			pumpkin.Parent = playerFolder.Evolutions
		end
	end
end)