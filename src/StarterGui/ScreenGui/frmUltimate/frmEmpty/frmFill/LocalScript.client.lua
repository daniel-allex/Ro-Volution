local StatFile = game:GetService("ReplicatedStorage"):WaitForChild("StatFile")
local playerFolder = StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local playerStats = playerFolder.playerStats
local stompLevel = playerStats.stompLevel
local UserInputService = game:GetService("UserInputService")


local roundStatus = game:GetService("ReplicatedStorage"):WaitForChild("RoundStatus")
local inRound = roundStatus:WaitForChild("inRound")

local MAX_STOMP = 15

if inRound.Value == true then
	script.Parent.Parent.Parent.Visible = true
else
	script.Parent.Parent.Parent.Visible = false

end

local percent = (stompLevel.Value + 3)/ (MAX_STOMP + 3)
percent = math.min(percent, 1)
percent = math.max(percent, .07)
script.Parent.Size = UDim2.new(percent, 0, 1, 0)

if percent == 1 and not UserInputService.TouchEnabled then
	script.Parent.Parent.Parent.frmStomp.Visible = true
	script.Parent.Parent.Parent.frmMobileStomp.Visible = false
elseif percent == 1 and UserInputService.TouchEnabled then
	script.Parent.Parent.Parent.frmStomp.Visible = false
	script.Parent.Parent.Parent.frmMobileStomp.Visible = true
else
	script.Parent.Parent.Parent.frmStomp.Visible = false
	script.Parent.Parent.Parent.frmMobileStomp.Visible = false
end

stompLevel.Changed:Connect(function()
	local percent = (stompLevel.Value + 3)/ (MAX_STOMP + 3)
	percent = math.min(percent, 1)
	percent = math.max(percent, .07)
	script.Parent.Size = UDim2.new(percent, 0, 1, 0)
	if percent == 1 and not UserInputService.TouchEnabled then
		script.Parent.Parent.Parent.frmStomp.Visible = true
		script.Parent.Parent.Parent.frmMobileStomp.Visible = false
	elseif percent == 1 and UserInputService.TouchEnabled then
		script.Parent.Parent.Parent.frmStomp.Visible = false
		script.Parent.Parent.Parent.frmMobileStomp.Visible = true
	else
		script.Parent.Parent.Parent.frmStomp.Visible = false
		script.Parent.Parent.Parent.frmMobileStomp.Visible = false
	end
end)

inRound.Changed:Connect(function()
	if inRound.Value == true then
		script.Parent.Parent.Parent.Visible = true
	else
		script.Parent.Parent.Parent.Visible = false

	end
end)