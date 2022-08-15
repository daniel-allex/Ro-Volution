local UserInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local roundStatus = replicatedStorage:WaitForChild("RoundStatus")
local inRound = roundStatus:WaitForChild("inRound")

if UserInputService.TouchEnabled then
	script.Parent.Visible = false
end

if inRound.Value == false then
	script.Parent.frmAttack.Visible = false
end

inRound.Changed:Connect(function()
	if not UserInputService.TouchEnabled and inRound.Value == true then
		script.Parent.Visible = true
		script.Parent.frmAttack.Visible = true
	end
end)