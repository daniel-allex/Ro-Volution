local event = game.ReplicatedStorage.Events.equipItem

local function EquipItem(plr, assetType, assetName)
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(plr.Name)
	if playerFolder then
		local default
		local location
		local equip
		
		if assetType == "Evolution" then
			default = "Dog"
			location = playerFolder.Evolutions
			equip = playerFolder.statnumbers.lastEquipped
		elseif assetType == "Effect" then
			default = "White Circle"
			location = playerFolder.Effects
			equip = playerFolder.statnumbers.lastEffect
		else
			default = "White Dash"
			location = playerFolder.Trails
			equip = playerFolder.statnumbers.lastTrail
		end
		
		if equip.Value == assetName then
			equip.Value = default
		else
			if location:FindFirstChild(assetName) then
				equip.Value = assetName
			end
		end
	end
end

event.OnServerEvent:Connect(EquipItem)