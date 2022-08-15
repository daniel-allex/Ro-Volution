local id = 1191930480
local debounce = false
local MarketplaceService = game:GetService("MarketplaceService")

script.Parent.Touched:Connect(function(p)
	if debounce == false then
		debounce = true
		local humanoid = p.Parent:FindFirstChild("Humanoid")
		if not humanoid then
			humanoid = p.Parent.Parent:FindFirstChild("Humanoid")
		end
		if humanoid then
			local player = game.Players:FindFirstChild(humanoid.Parent.Name)

			if player then
				MarketplaceService:PromptProductPurchase(player, id)
			end
		end
		
		debounce = false
	end
end)