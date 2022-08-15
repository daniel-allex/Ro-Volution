local StatFile = game:GetService("ReplicatedStorage"):WaitForChild("StatFile")
local playerFolder = StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local playerStats = playerFolder.playerStats
local evoLvl = playerStats.evoLvl
local UserInputService = game:GetService("UserInputService")


local roundStatus = game:GetService("ReplicatedStorage"):WaitForChild("RoundStatus")
local inRound = roundStatus:WaitForChild("inRound")

if inRound.Value == true then
	script.Parent.Parent.Parent.Parent.Visible = true
else
	script.Parent.Parent.Parent.Parent.Visible = false
end

if UserInputService.TouchEnabled then
	script.Parent.Parent.Parent.Parent.AnchorPoint = Vector2.new(1, 0)
	script.Parent.Parent.Parent.Parent.Position = UDim2.new(0.99, 0, 0, 0)
end

local percent = 0.183 + 0.047 * evoLvl.Value - 3.08 * 10^(-4) * (evoLvl.Value)^2
percent = math.min(percent, 1)
percent = math.max(percent, .07)
script.Parent.Size = UDim2.new(1, 0, percent, 0)

evoLvl.Changed:Connect(function()
	local percent = 0.183 + 0.047 * evoLvl.Value - 3.08 * 10^(-4) * (evoLvl.Value)^2
	if evoLvl.Value >= 20 then
		script.Parent.Parent.Parent.Parent.frmMax.ViewportFrame.ImageColor3 = Color3.new(1,1,1)
		script.Parent.Parent.Parent.Parent.frmMid.ViewportFrame.ImageColor3 = Color3.new(1,1,1)
	elseif evoLvl.Value >= 10 then
		script.Parent.Parent.Parent.Parent.frmMax.ViewportFrame.ImageColor3 = Color3.new(0,0,0)
		script.Parent.Parent.Parent.Parent.frmMid.ViewportFrame.ImageColor3 = Color3.new(1,1,1)
	else
		script.Parent.Parent.Parent.Parent.frmMax.ViewportFrame.ImageColor3 = Color3.new(0,0,0)
		script.Parent.Parent.Parent.Parent.frmMid.ViewportFrame.ImageColor3 = Color3.new(0,0,0)
	end
	percent = math.min(percent, 1)
	percent = math.max(percent, .23)
	script.Parent.Size = UDim2.new(1, 0, percent, 0)
end)

inRound.Changed:Connect(function()
	if inRound.Value == true then
		script.Parent.Parent.Parent.Parent.Visible = true
	else
		script.Parent.Parent.Parent.Parent.Visible = false
	end
end)
