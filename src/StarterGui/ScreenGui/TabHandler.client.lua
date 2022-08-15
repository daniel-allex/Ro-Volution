local index = script.Parent.Index
local Minimize = {script.Parent:WaitForChild("FriendRewards"), script.Parent:WaitForChild("inventory"), script.Parent:WaitForChild("CrateShop"), script.Parent:WaitForChild("devproducts"), script.Parent:WaitForChild("Shop")}

local function adjustTabs(Main)
	for i,v in pairs(Minimize) do
		if v.Name ~= Main then
			v.Visible = false
		else
			v.Visible = true
			if v.Name == "CrateShop" then
				if #(v.frmSelection.Evolutions:GetChildren()) > 3 then
					v.NoCratesLabel.Visible = false
				else
					v.NoCratesLabel.Visible = true
				end
			end
		end
	end
end

index.Changed:Connect(function()
	adjustTabs(index.Value)
end)