local id = 21709212
local debounce = false
local MarketplaceService = game:GetService("MarketplaceService")

local function checkOwnership(plr)
	if MarketplaceService:UserOwnsGamePassAsync(plr.UserId, id) then
		return true
	end
	return false
end


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
				if not checkOwnership((player)) then
					MarketplaceService:PromptGamePassPurchase(player, id)
				end
			end
		end
		
		debounce = false
	end
end)