repeat wait() until game.ReplicatedStorage.Assets.GUI.buyCredits.Completed.Value == true
repeat wait() until game.ReplicatedStorage.StatFile:FindFirstChild(game.Players.LocalPlayer.Name)

local mapLoaded = game.ReplicatedStorage.Events.mapLoaded

local awardClient = game.ReplicatedStorage.Events.awardClient

local clientCopy = game.ReplicatedStorage.Assets.GUI.inventory:Clone()
clientCopy.Parent = script.Parent

local clientCrates = game.ReplicatedStorage.Assets.GUI.CrateShop:Clone()
clientCrates.Parent = script.Parent

local clientShop = game.ReplicatedStorage.Assets.GUI.Shop:Clone()
clientShop.Parent = script.Parent

local clientDevproducts = game.ReplicatedStorage.Assets.GUI.devproducts:Clone()
clientDevproducts.Parent = script.Parent

local clientBillboard1 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard1.Adornee = workspace.buyTokens.Display
clientBillboard1.Face = Enum.NormalId.Front
clientBillboard1.Parent = script.Parent.Parent

local clientBillboard2 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard2.Adornee = workspace.buyTokens.Display
clientBillboard2.Face = Enum.NormalId.Back
clientBillboard2.Parent = script.Parent.Parent

local clientBillboard3 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard3.Adornee = workspace.buyTokens.Display
clientBillboard3.Face = Enum.NormalId.Left
clientBillboard3.Parent = script.Parent.Parent

local clientBillboard4 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard4.Adornee = workspace.buyTokens.Display
clientBillboard4.Face = Enum.NormalId.Right
clientBillboard4.Parent = script.Parent.Parent

--

local clientBillboard5 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard5.Adornee = workspace.buyTokens2.Display
clientBillboard5.Face = Enum.NormalId.Front
clientBillboard5.Parent = script.Parent.Parent

local clientBillboard6 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard6.Adornee = workspace.buyTokens2.Display
clientBillboard6.Face = Enum.NormalId.Back
clientBillboard6.Parent = script.Parent.Parent

local clientBillboard7 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard7.Adornee = workspace.buyTokens2.Display
clientBillboard7.Face = Enum.NormalId.Left
clientBillboard7.Parent = script.Parent.Parent

local clientBillboard8 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard8.Adornee = workspace.buyTokens2.Display
clientBillboard8.Face = Enum.NormalId.Right
clientBillboard8.Parent = script.Parent.Parent

--

local clientBillboard9 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard9.Adornee = workspace.buyTokens3.Display
clientBillboard9.Face = Enum.NormalId.Front
clientBillboard9.Parent = script.Parent.Parent

local clientBillboard10 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard10.Adornee = workspace.buyTokens3.Display
clientBillboard10.Face = Enum.NormalId.Back
clientBillboard10.Parent = script.Parent.Parent

local clientBillboard11 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard11.Adornee = workspace.buyTokens3.Display
clientBillboard11.Face = Enum.NormalId.Left
clientBillboard11.Parent = script.Parent.Parent

local clientBillboard12 = game.ReplicatedStorage.Assets.GUI.buyCredits:Clone()
clientBillboard12.Adornee = workspace.buyTokens3.Display
clientBillboard12.Face = Enum.NormalId.Right
clientBillboard12.Parent = script.Parent.Parent

local clientAward = game.ReplicatedStorage.Assets.GUI.DailyAward:Clone()
clientAward.Parent = script.Parent

local owned = game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].Evolutions
local owned_Effects = game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].Effects
local owned_Trails = game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].Trails

local getCrateFromStreak = {
	[0] = "Wood Crate",
	[1] = "Stone Crate",
	[2] = "Stone Crate",
	[3] = "Iron Crate",
	[4] = "Gold Crate",
	[5] = "Ruby Crate",
	[6] = "Diamond Crate"
}

local getImageFromMap = {
	["Grass Map"] = "http://www.roblox.com/asset/?id=7364053093",
	["Snow Map"] = "http://www.roblox.com/asset/?id=7364051898",
	["Island Map"] = "http://www.roblox.com/asset/?id=7364050950"
}

local getNameFromMap = {
	["Grass Map"] = "Delphic Jungle",
	["Snow Map"] = "Jagged Tundra",
	["Island Map"] = "Barbaric Islands"
}

local getTextLabelFromMap = {
	["Grass Map"] = script.Parent.chosenMap.ImageLabel.Text1,
	["Snow Map"] = script.Parent.chosenMap.ImageLabel.Text2,
	["Island Map"] = script.Parent.chosenMap.ImageLabel.Text1
}

local function showDailyAward(streak)
	if script.Parent.Index.Value ~= "Locked" then
		clientAward.Visible = true
		script.Parent.Index.Value = "Locked"
	end
	
	for i = 1, streak + 1 do
		clientAward.Scroll[i].BackgroundColor3 = Color3.new(129/255, 199/255, 132/255)
	end
end

awardClient.OnClientEvent:Connect(showDailyAward)

local function showChosenMap(mapName)
	script.Parent.chosenMap.ImageLabel.Image = getImageFromMap[mapName]
	getTextLabelFromMap[mapName].Text = getNameFromMap[mapName]
	
	if getTextLabelFromMap[mapName]:FindFirstChild("Shadow") then
		script.Parent.chosenMap.ImageLabel.Text1.Visible = true
		script.Parent.chosenMap.ImageLabel.Text2.Visible = false
		getTextLabelFromMap[mapName].Shadow.Text = getNameFromMap[mapName]
	else
		script.Parent.chosenMap.ImageLabel.Text1.Visible = false
		script.Parent.chosenMap.ImageLabel.Text2.Visible = true
	end
	
	if script.Parent.Index.Value ~= "Locked" then
		script.Parent.chosenMap.Visible = true
		script.Parent.Index.Value = "Locked"
		script.Parent.chosenMap.tick:Play()
	end
	wait(2)
	script.Parent.chosenMap.Visible = false
	script.Parent.Index.Value = "Home"
end

mapLoaded.OnClientEvent:Connect(showChosenMap)

for i,v in pairs(clientCopy.frmSelection.Evolutions:GetChildren()) do
	if v.Name ~= "UIGridLayout" then
		if owned:FindFirstChild(v.frmDetails.btnEquip.evoLine.Value) then
			if v.Name ~= game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].statnumbers.lastEquipped.Value then
				v.Name = "0"..v.Name
				v.frmDetails.btnEquip.txtBuy.Text = "Equip"
				v.frmDetails.btnEquip.txtBuy.txtShadow.Text = "Equip"
				v.frmDetails.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
				v.frmDetails.btnEquip.Status.Value = "Equip"
			end
		elseif game.ReplicatedStorage.EvolutionLines:FindFirstChild(v.frmDetails.btnEquip.evoLine.Value) and game.ReplicatedStorage.EvolutionLines[v.frmDetails.btnEquip.evoLine.Value].rarity.Value == -2 then
			v.Name = "1"..v.Name
			v.frmDetails.btnEquip.txtBuy.Text = "Buy"
			v.frmDetails.btnEquip.txtBuy.txtShadow.Text = "Buy"
			v.frmDetails.btnEquip.Status.Value = "Buy"
			v.frmDetails.btnEquip.Gamepass.Value = game.ReplicatedStorage.Assets.Gamepasses.VIP.Value
			v.frmDetails.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
		elseif game.ReplicatedStorage.EvolutionLines:FindFirstChild(v.frmDetails.btnEquip.evoLine.Value) and game.ReplicatedStorage.EvolutionLines[v.frmDetails.btnEquip.evoLine.Value].rarity.Value == -1 then
			v.Name = "1"..v.Name
			v.frmDetails.btnEquip.txtBuy.Text = "Buy"
			v.frmDetails.btnEquip.txtBuy.txtShadow.Text = "Buy"
			v.frmDetails.btnEquip.Status.Value = "Buy"
			v.frmDetails.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
			if v.frmDetails.btnEquip.evoLine.Value == "Yeti" then
				v.frmDetails.btnEquip.Gamepass.Value = game.ReplicatedStorage.Assets.Gamepasses.FrostMonsterPack.Value
			elseif v.frmDetails.btnEquip.evoLine.Value == "Pumpkin" then
				v.frmDetails.btnEquip.Gamepass.Value = game.ReplicatedStorage.Assets.Gamepasses.PumpkinMonsterPack.Value
			end
		else
			if v.Name == "Looney Tunes" then
				v:Destroy()
			else
				v.Name = "1"..v.Name
				v.ImageTransparency = 0.9
				v.frmDetails.btnEquip.txtBuy.Text = "Locked"
				v.frmDetails.btnEquip.txtBuy.txtShadow.Text = "Locked"
				v.frmDetails.btnEquip.Status.Value = "Locked"
				v.frmDetails.btnEquip.Round.ImageColor3 = Color3.new(158/255, 158/255, 158/255)
				v.frmDetails.btnEquip.imgShadow.ImageColor3 = Color3.new(121/255, 121/255, 121/255)
			end
		end
	end
end

for i,v in pairs(clientCopy.frmSelection.Effects:GetChildren()) do
	if v.Name ~= "UIGridLayout" then
		if owned_Effects:FindFirstChild(v.btnEquip.effect.Value) then
			if v.Name ~= game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].statnumbers.lastEquipped.Value then
				v.Name = "0"..v.Name
				v.btnEquip.txtBuy.Text = "Equip"
				v.btnEquip.txtBuy.txtShadow.Text = "Equip"
				v.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
				v.btnEquip.Status.Value = "Equip"
			end
		elseif game.ReplicatedStorage.Assets.Effects:FindFirstChild(v.btnEquip.effect.Value) and game.ReplicatedStorage.Assets.Effects[v.btnEquip.effect.Value].rarity.Value == -2 then
			v.Name = "1"..v.Name
			v.btnEquip.txtBuy.Text = "Buy"
			v.btnEquip.txtBuy.txtShadow.Text = "Buy"
			v.btnEquip.Status.Value = "Buy"
			v.btnEquip.Gamepass.Value = game.ReplicatedStorage.Assets.Gamepasses.VIP.Value
			v.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
		else
			v.Name = "1"..v.Name
			v.btnEquip.txtBuy.Text = "Locked"
			v.btnEquip.txtBuy.txtShadow.Text = "Locked"
			v.btnEquip.Status.Value = "Locked"
			v.btnEquip.Round.ImageColor3 = Color3.new(158/255, 158/255, 158/255)
			v.btnEquip.imgShadow.ImageColor3 = Color3.new(121/255, 121/255, 121/255)
		end
	end
end

for i,v in pairs(clientCopy.frmSelection.Trails:GetChildren()) do
	if v.Name ~= "UIGridLayout" then
		if owned_Trails:FindFirstChild(v.btnEquip.trail.Value) then
			if v.Name ~= game.ReplicatedStorage.StatFile[game.Players.LocalPlayer.Name].statnumbers.lastEquipped.Value then
				v.Name = "0"..v.Name
				v.btnEquip.txtBuy.Text = "Equip"
				v.btnEquip.txtBuy.txtShadow.Text = "Equip"
				v.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
				v.btnEquip.Status.Value = "Equip"
			end
		elseif game.ReplicatedStorage.Assets.Trails:FindFirstChild(v.btnEquip.trail.Value) and game.ReplicatedStorage.Assets.Trails[v.btnEquip.trail.Value].rarity.Value == -2 then
			v.Name = "1"..v.Name
			v.btnEquip.txtBuy.Text = "Buy"
			v.btnEquip.txtBuy.txtShadow.Text = "Buy"
			v.btnEquip.Status.Value = "Buy"
			v.btnEquip.Gamepass.Value = game.ReplicatedStorage.Assets.Gamepasses.VIP.Value
			v.btnEquip.Round.ImageColor3 = Color3.new(100/255, 181/255, 246/255)
		else
			v.Name = "1"..v.Name
			v.btnEquip.txtBuy.Text = "Locked"
			v.btnEquip.txtBuy.txtShadow.Text = "Locked"
			v.btnEquip.Status.Value = "Locked"
			v.btnEquip.Round.ImageColor3 = Color3.new(158/255, 158/255, 158/255)
			v.btnEquip.imgShadow.ImageColor3 = Color3.new(121/255, 121/255, 121/255)
		end
	end
end

game.ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	print("changed")
	if game.ReplicatedStorage.RoundStatus.inRound.Value == false then
		print(game.ReplicatedStorage.RoundStatus.inRound.Value)
		local copy = game.ReplicatedStorage.Assets.TempLoc:WaitForChild("Leaderboard"):Clone()
		copy.Parent = script.Parent
		copy.Visible = true
		script.Parent.Index.Value = "Locked"
	end
end)