repeat wait() until script.Parent.Parent.Parent.Parent.Completed.Value == true

local buttonColor = {
	["Selected"] = Color3.new(30/255, 136/255, 229/255),
	["SelectedShadow"] = Color3.new(22/255, 101/255, 171/255),
	["Unselected"] = Color3.new(100/255, 181/255, 246/255),
	["UnselectedSpecial"] = Color3.new(253/255, 216/255, 53/255),
	["SelectedSpecial"] = Color3.new(251/255, 192/255, 45/255),
	["SpecialShadow"] = Color3.new(212/255, 179/255, 44/255),
	["SpecialSelectedShadow"] = Color3.new(203/255, 153/255, 35/255),
	["Shadow"] = Color3.new(83/255, 151/255, 203/255),
}

local selected = script.Parent.Parent.selectedCrate
local specialMode = script.Parent.Parent.Parent.Parent.specialMode

local function updateData(crate)
	local rarityData = crate.Data.Rarities
	for i,v in pairs(rarityData:GetChildren()) do
		script.Parent.frmRarities[v.Name].Text = v.Name .. ": " .. v.Value .. "%"
	end
	
	script.Parent.txtName.Text = crate.Name
	script.Parent.Parent.selectedCrate.Value = crate
	script.Parent.txtPrice.Text = crate.Data.Price.Value
	script.Parent.ViewportFrame.objAnimal.Value = crate
	script.Parent.btnBuy.crate.Value = crate
	
	if game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].statnumbers.animalBux.Value >= crate.Data.Price.Value then
		if specialMode.Value then
			script.Parent.btnBuy.Round.ImageColor3 = buttonColor.UnselectedSpecial
			script.Parent.btnBuy.imgShadow.ImageColor3 = buttonColor.SpecialShadow
		else
			script.Parent.btnBuy.Round.ImageColor3 = buttonColor.Unselected
			script.Parent.btnBuy.imgShadow.ImageColor3 = buttonColor.Shadow
		end
	else
		script.Parent.btnBuy.Round.ImageColor3 = buttonColor.Unselected
		script.Parent.btnBuy.imgShadow.ImageColor3 = buttonColor.Shadow
	end
end

--updateData(script.Parent.Parent.selectedCrate.Value)

updateData(game.ReplicatedStorage.Assets.CrateData["Wood Crate"])

script.Parent.Parent.selectedCrate.Changed:Connect(function()
	updateData(script.Parent.Parent.selectedCrate.Value)
end)