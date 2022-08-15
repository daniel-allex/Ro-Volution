local player = game.Players.LocalPlayer
local StatFile = game.ReplicatedStorage.StatFile
local playerFolder = StatFile:WaitForChild(player.Name)
local crates = playerFolder.Crates
local template = script.Parent.Template

local CrateToName = {
	["Wood Crate"] = 1,
	["Stone Crate"] = 2,
	["Iron Crate"] = 3,
	["Gold Crate"] = 4,
	["Ruby Crate"] = 5,
	["Diamond Crate"] = 6
}

local count = 0

for i,v in pairs(crates:GetChildren()) do
	local Clone = template:Clone()
	Clone.Name = CrateToName[v.Name]
	Clone.Parent = script.Parent
	Clone.Visible = true
	Clone.txtName.Text = v.Name
	local CrateData = game.ReplicatedStorage.Assets.CrateData:FindFirstChild(v.Name)
	Clone.btnEquip.crate.Value = CrateData
	Clone.ViewportFrame.objAnimal.Value = CrateData
	count = count + 1
end

if count > 0 then
	script.Parent.Parent.Parent.NoCratesLabel.Visible = false
end

crates.ChildAdded:Connect(function(item)
	repeat wait() until item.Name ~= "Folder"
	
	local Clone = template:Clone()
	if CrateToName[item.Name] ~= nil then
		Clone.Name = CrateToName[item.Name]
		Clone.Parent = script.Parent
		Clone.Visible = true
		Clone.txtName.Text = item.Name
		local CrateData = game.ReplicatedStorage.Assets.CrateData:FindFirstChild(item.Name)
		Clone.btnEquip.crate.Value = CrateData
		Clone.ViewportFrame.objAnimal.Value = CrateData
	else
		Clone:Destroy()
	end	
	
end)
