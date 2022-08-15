repeat wait() until game.Players.LocalPlayer.Character

local screenGUI = script.Parent.Parent.Parent.Parent
local openCrateRemote = game.ReplicatedStorage.Events.openCrate
local bindable = game.ReplicatedStorage.Events.RequestCrateOpen
local RunService = game:GetService("RunService")
local interval = 0
local debounce = false
local delta = tick()

local rarities = {
	[0] = {["Name"] = "Common",
		["Color"] = Color3.new(117/255, 117/255, 117/255)
	},
	[1] = {["Name"] = "Rare",
		["Color"] = Color3.new(30/255, 136/255, 229/255)
	},
	[2] = {["Name"] = "Very Rare",
		["Color"] = Color3.new(126/255, 87/255, 194/255)
	},
	[3] = {["Name"] = "Mythic",
		["Color"] = Color3.new(240/255, 98/255, 146/255)
	},
	[4] = {["Name"] = "Legendary",
		["Color"] = Color3.new(211/255, 47/255, 47/255)
	}
}

local compensationRarities = {
	["Common"] = 0,
	["Rare"] = 1,
	["Very Rare"] = 2,
	["Mythic"] = 3,
	["Legendary"] = 4,
}

local reverseRarities = {
	[0] = "Common",
	[1] = "Rare",
	[2] = "Very Rare",
	[3] = "Mythic",
	[4] = "Legendary"
}


local function chooseRarity(crate)
	local randNum = math.random(100)
	local selected
	
	local Rarities = crate.Data.Rarities
	
	if randNum <= Rarities["Common"].Value then
		selected = 0
	elseif randNum <= Rarities["Common"].Value + Rarities["Rare"].Value then
		selected = 1
	elseif randNum <= Rarities["Common"].Value + Rarities["Rare"].Value + Rarities["Very Rare"].Value then
		selected = 2
	elseif randNum <= Rarities["Common"].Value + Rarities["Rare"].Value + Rarities["Very Rare"].Value + Rarities["Mythic"].Value then
		selected = 3
	else
		selected = 4
	end
	--print("chosen!".. selected)
	return selected
end

local function chooseItem(crate, selectedRarity)
	local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(game.Players.LocalPlayer.Name)
	if playerFolder then
		local options = {}
		
		for i,v in pairs(game.ReplicatedStorage.EvolutionLines:GetChildren()) do
			if v.rarity.Value == selectedRarity and v.Name ~= "Dog"  and v.Name ~= "Looney Tunes" then
				table.insert(options, v)
			end
		end
			
		for i,v in pairs(game.ReplicatedStorage.Assets.Effects:GetChildren()) do
			if v.rarity.Value == selectedRarity and v.Name ~= "White Circle" then
				table.insert(options, v)
			end
		end
		
		for i,v in pairs(game.ReplicatedStorage.Assets.Trails:GetChildren()) do
			if v.rarity.Value == selectedRarity then
				table.insert(options, v)
			end
		end
		
		local selectedItem = options[math.random(#options)]
		
		return selectedItem
	end
end

local function setupItems(crate, actual)
	local int1 = 0
	local int2 = 0
	
	for i = 1, 25 do
		int1 = int1 + 1
		if int1 == 10 then
			int1 = 0
			int2 = int2 + 1
		end
		
		local rarity
		local selectedItem
		
		if i == 23 then
			selectedItem = actual
			rarity = selectedItem.rarity.Value
		else
			rarity = chooseRarity(crate)
			selectedItem = chooseItem(crate, rarity)
			print("we should have a selected item")
		end
	
		local template
		
		print(rarity)
		print(selectedItem.Name)
		
	
		if selectedItem.Parent.Name == "EvolutionLines" then
			template = script.Parent.Evolution
			local templateClone = template:Clone()
			templateClone.Visible = true
			templateClone.Parent = script.Parent
			templateClone.Name = ""..int2..int1
			templateClone.stage1.ViewportFrame.objAnimal.Value = game.ReplicatedStorage.EvolutionLines[selectedItem.Name]["1"]
			templateClone.stage2.ViewportFrame.objAnimal.Value = game.ReplicatedStorage.EvolutionLines[selectedItem.Name]["2"]
			templateClone.stage3.ViewportFrame.objAnimal.Value = game.ReplicatedStorage.EvolutionLines[selectedItem.Name]["3"]
			templateClone.ImageColor3 = rarities[rarity].Color
		elseif selectedItem.Parent.Name == "Trails" then
			template = script.Parent.Trail
			local templateClone = template:Clone()
			templateClone.Visible = true
			templateClone.Parent = script.Parent
			templateClone.Name = ""..int2..int1
			templateClone.txtLabel.Text = selectedItem.Name
			templateClone.Sequence.UIGradient.Color = selectedItem.Trail.Color
			templateClone.ImageColor3 = rarities[rarity].Color
		elseif selectedItem.Parent.Name == "Effects" then
			template = script.Parent.Effect
			local templateClone = template:Clone()
			templateClone.Visible = true
			templateClone.Parent = script.Parent
			templateClone.Name = ""..int2..int1
			templateClone.txtLabel.Text = selectedItem.Name
			templateClone.ViewportFrame.obj.Value = game.ReplicatedStorage.Assets.Effects:FindFirstChild(selectedItem.Name)
			templateClone.ImageColor3 = rarities[rarity].Color
		end
	end
end

local function spinCrate()
	script.Parent:TweenPosition(UDim2.new(0.5, 0, math.random(-841, -810) / 100, 0), "Out", "Quint", 7)
end

local function showReward(item, compensation)
	screenGUI.Crate.Visible = false
	
	local template
	
	if item.Parent.Name == "EvolutionLines" then
		if compensation == 0 then
			template = screenGUI.winEvolution:Clone()
			template.Parent = screenGUI
		else
			template = screenGUI.winEvolutionOwned:Clone()
			template.Parent = screenGUI
			template.txtCompensation.Text = "" .. compensation .. " Rewarded"
		end
		
		template.Visible = true
		template.stage1.ViewportFrame.objAnimal.Value = game.ReplicatedStorage.EvolutionLines[item.Name]["1"]
		template.stage2.ViewportFrame.objAnimal.Value = game.ReplicatedStorage.EvolutionLines[item.Name]["2"]
		template.stage3.ViewportFrame.objAnimal.Value = game.ReplicatedStorage.EvolutionLines[item.Name]["3"]
		template.options.txtRarity.TextColor3 = rarities[game.ReplicatedStorage.EvolutionLines[item.Name]["rarity"].Value].Color
		template.options.txtRarity.Text = rarities[game.ReplicatedStorage.EvolutionLines[item.Name]["rarity"].Value].Name
		template.options.btnEquip.evoLine.Value = item.Name
	elseif item.Parent.Name == "Trails" then
		if compensation == 0 then
			template = screenGUI.winTrail:Clone()
			template.Parent = screenGUI
		else
			template = screenGUI.winTrailOwned:Clone()
			template.Parent = screenGUI
			template.txtCompensation.Text = "" .. compensation .. " Rewarded"
		end
		
		template.Visible = true
		template.txtLabel.Text = item.Name
		template.Sequence.UIGradient.Color = item.Trail.Color
		template.options.txtRarity.TextColor3 = rarities[game.ReplicatedStorage.Assets.Trails[item.Name]["rarity"].Value].Color
		template.options.txtRarity.Text = rarities[game.ReplicatedStorage.Assets.Trails[item.Name]["rarity"].Value].Name
		template.options.btnEquip.evoLine.Value = item.Name

	elseif item.Parent.Name == "Effects" then
		if compensation == 0 then
			template = screenGUI.winEffects:Clone()
			template.Parent = screenGUI
		else
			template = screenGUI.winEffectsOwned:Clone()
			template.Parent = screenGUI
			template.txtCompensation.Text = "" .. compensation .. " Rewarded"
		end
		
		template.Visible = true
		template.txtLabel.Text = item.Name
		template.ViewportFrame.obj.Value = game.ReplicatedStorage.Assets.Effects:FindFirstChild(item.Name)
		template.options.txtRarity.TextColor3 = rarities[game.ReplicatedStorage.Assets.Effects[item.Name]["rarity"].Value].Color
		template.options.txtRarity.Text = rarities[game.ReplicatedStorage.Assets.Effects[item.Name]["rarity"].Value].Name
		template.options.btnEquip.evoLine.Value = item.Name

	end
	script.Parent.crateReward:Play()
end


local function beginCrate(crate)
	for i,v in pairs(script.Parent:GetChildren()) do
		if v.Name ~= "crateReward" and v.Name ~= "crateTick" and v.Name ~= "UIGridLayout" and v.Name ~= "CrateClient" and v.Name ~= "Effect" and v.Name ~= "Evolution" and v.Name ~= "Trail" then
			v:Destroy()
		end
	end
	
	script.Parent.Position = UDim2.new(0.5, 0, 0.02, 0)
	
	interval = 0
	local chosenData = openCrateRemote:InvokeServer(crate)
	local chosenItem = chosenData.Item
	local compensation = chosenData.Compensation
	print(chosenItem.Name)
	setupItems(crate, chosenItem)
	wait(.1)
	spinCrate()
	wait(7)
	showReward(chosenItem, compensation)
end

script.Parent.Changed:Connect(function()
	if not debounce and tick() - delta > interval * 0.01 and (script.Parent.Position.Y.Scale) <= (-.26  - interval * 0.39) then
		debounce = true
		delta = tick()
		script.Parent.crateTick:Play()
		interval = interval + 1
		debounce = false
	end
end)

bindable.Event:Connect(beginCrate)