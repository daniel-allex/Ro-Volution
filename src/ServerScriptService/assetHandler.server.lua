function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local inventory = ReplicatedStorage.Assets.GUI.inventory
local template = inventory.frmSelection.Evolutions.Template
local template_Effects = inventory.frmSelection.Effects.Template
local template_Trails = inventory.frmSelection.Trails.Template

local crateShop = ReplicatedStorage.Assets.GUI.CrateShop
local templateCrates = crateShop.frmSelection.Effects.frmListed.Template
local rarities = crateShop.frmSelection.Effects.frmDetails.frmRarities
local dailyRewardGUI = ReplicatedStorage.Assets.GUI.DailyAward
local templateDailyReward = dailyRewardGUI.Scroll.Template

local gamepassShop = ReplicatedStorage.Assets.GUI.Shop
local templateGamePass = gamepassShop.frmSelection.Evolutions.Template

local devproductShop = ReplicatedStorage.Assets.GUI.devproducts
local templateDevproduct = devproductShop.frmSelection.Evolutions.Template

local creditsBillboard = ReplicatedStorage.Assets.GUI.buyCredits
local templateCreditBillboard = creditsBillboard.Frame.Template

local evoLines = ReplicatedStorage:WaitForChild("EvolutionLines"):Clone():GetChildren()
local effects = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Effects"):Clone():GetChildren()
local trails = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Trails"):Clone():GetChildren()
local crates = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("CrateData"):Clone():GetChildren()
local gamePasses = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gamepasses"):Clone():GetChildren()
local devproducts = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Devproducts"):Clone():GetChildren()

local int1 = 0
local int2 = 0

local DailyRewardOrder = {"Wood Crate", "Stone Crate", "Stone Crate", "Iron Crate", "Gold Crate", "Ruby Crate", "Diamond Crate"}

local rarities = {
	[-2] = {["Name"] = "VIP",
		["Color"] = Color3.new(245/255, 127/255, 23/255)
	},
	[-1] = {["Name"] = "Elite",
		["Color"] = Color3.new(38/255, 166/255, 154/255)
	},
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
	},
	[10] = {["Name"] = "Limited",
			["Color"] = Color3.new(38/255, 166/255, 154/255)
		}
}


table.sort(evoLines, function (a, b)
	return a.rarity.Value < b.rarity.Value --sorted in reverse order
end)

table.sort(effects, function (a, b)
	return a.rarity.Value < b.rarity.Value --sorted in reverse order
end)

table.sort(trails, function (a, b)
	return a.rarity.Value < b.rarity.Value --sorted in reverse order
end)

table.sort(crates, function (a, b)
	return a.Data.Price.Value < b.Data.Price.Value --sorted in reverse order
end)

table.sort(gamePasses, function (a, b)
	return a.Price.Value < b.Price.Value --sorted in reverse order
end)

table.sort(devproducts, function (a, b)
	return a.Price.Value < b.Price.Value --sorted in reverse order
end)

-- Inventory Stuff

for i,v in pairs(evoLines) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end
		
	local copy = template:Clone()
	local rarity = copy.frmDetails.txtRarity
	rarity.Text = rarities[v.rarity.Value].Name
	rarity.TextColor3 = rarities[v.rarity.Value].Color
	copy.frmDetails.btnEquip.evoLine.Value = v.Name
	local stages = copy.frmAnimals
	stages.stage1.ViewportFrame.objAnimal.Value = ReplicatedStorage.EvolutionLines[v.Name]["1"]
	stages.stage2.ViewportFrame.objAnimal.Value = ReplicatedStorage.EvolutionLines[v.Name]["2"]
	stages.stage3.ViewportFrame.objAnimal.Value = ReplicatedStorage.EvolutionLines[v.Name]["3"]
	copy.Name = ""..int2..int1
	copy.Parent = inventory.frmSelection.Evolutions
end

int1 = 0
int2 = 0

for i,v in pairs(effects) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end

	local copy = template_Effects:Clone()
	local rarity = copy.txtRarity
	rarity.Text = rarities[v.rarity.Value].Name
	rarity.TextColor3 = rarities[v.rarity.Value].Color
	copy.btnEquip.effect.Value = v.Name
	copy.ViewportFrame.objAnimal.Value = ReplicatedStorage.Assets.Effects[v.Name]
	copy.txtName.Text = v.Name
	copy.Name = ""..int2..int1
	copy.Parent = inventory.frmSelection.Effects
end

int1 = 0
int2 = 0

for i,v in pairs(trails) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end

	local copy = template_Trails:Clone()
	local rarity = copy.txtRarity
	rarity.Text = rarities[v.rarity.Value].Name
	rarity.TextColor3 = rarities[v.rarity.Value].Color
	copy.btnEquip.trail.Value = v.Name
	copy.Sequence.UIGradient.Color = v.Trail.Color
	copy.txtName.Text = v.Name
	copy.Name = ""..int2..int1
	copy.Parent = inventory.frmSelection.Trails
end

template_Trails:Destroy()
template_Effects:Destroy()
template:Destroy()
inventory.Completed.Value = true

-- Crate Stuff

int1 = 0
int2 = 0

for i,v in pairs(crates) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end
	
	local copy = templateCrates:Clone()
	copy.Parent = crateShop.frmSelection.Effects.frmListed
	copy.txtName.Text = v.Name
	copy.ViewportFrame.objAnimal.Value = ReplicatedStorage.Assets.CrateData[v.Name]
	copy.Name = ""..int2..int1

end

templateCrates:Destroy()
crateShop.Completed.Value = true

-- Reward Stuff

for i,v in pairs(DailyRewardOrder) do	
	local copy = templateDailyReward:Clone()
	copy.Parent = dailyRewardGUI.Scroll
	copy.txtName.Text = "Day " .. i
	copy.ViewportFrame.objAnimal.Value = ReplicatedStorage.Assets.CrateData[v]
	print(v)
	copy.Name = i
	
end

templateDailyReward:Destroy()
dailyRewardGUI.Completed.Value = true

-- Gamepasses
int1 = 0
int2 = 0

for i,v in pairs(gamePasses) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end
	local id = v.Value
	local Asset
	if v.Gamepass.Value then
		Asset = game:GetService("MarketplaceService"):GetProductInfo(id,Enum.InfoType.GamePass)
	else
		Asset = game:GetService("MarketplaceService"):GetProductInfo(id,Enum.InfoType.Product)
	end
	
	local copy = templateGamePass:Clone()
	copy.Parent = gamepassShop.frmSelection.Evolutions
	copy.imgIcon.Image = "rbxassetid://"..Asset.IconImageAssetId
	copy.frmDetails.txtPrice.Text = v.Price.Value
	copy.txtDesc.Text = v.Description.Value
	copy.frmDetails.btnBuy.Gamepass.Value = id
	copy.frmDetails.btnBuy.IsGamepass.Value = v.Gamepass.Value
	copy.Name = ""..int2..int1

end

templateGamePass:Destroy()
gamepassShop.Completed.Value = true

-- Devproducts
int1 = 0
int2 = 0

for i,v in pairs(devproducts) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end
	local copy = templateDevproduct:Clone()
	copy.Parent = devproductShop.frmSelection.Evolutions
	copy.btnBuy.txtPrice.Text = v.Price.Value
	copy.btnBuy.Devproduct.Value = v.ID.Value
	copy.txtAmt.Text = comma_value(v.AnimalBux.Value)
	copy.Name = ""..int2..int1

end

templateDevproduct:Destroy()
devproductShop.Completed.Value = true

-- Billboard Devproducts
int1 = 0
int2 = 0

for i,v in pairs(devproducts) do
	int1 = int1 + 1
	if int1 == 10 then
		int1 = 0
		int2 = int2 + 1
	end
	local copy = templateCreditBillboard:Clone()
	copy.Parent = creditsBillboard.Frame
	copy.btnBuy.txtPrice.Text = v.Price.Value
	copy.btnBuy.Devproduct.Value = v.ID.Value
	copy.txtAmt.Text = comma_value(v.AnimalBux.Value)
	copy.Name = ""..int2..int1

end

templateCreditBillboard:Destroy()
creditsBillboard.Completed.Value = true