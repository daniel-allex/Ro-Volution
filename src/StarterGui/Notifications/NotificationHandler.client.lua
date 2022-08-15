local RS = game:GetService("ReplicatedStorage")
local SG = game:GetService("StarterGui")
local SocialService = game:GetService("SocialService")
local Notif = RS.Events.sendNotification
local invitedPlayers = RS.Events.invitedPlayers
local StatFile = RS.StatFile
local PlayerFolder = StatFile:WaitForChild(game.Players.LocalPlayer.Name)

local animalBux = PlayerFolder.statnumbers.animalBux

local currentAnimalBux = animalBux.Value

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundStatus = ReplicatedStorage.RoundStatus
local inround = RoundStatus.inRound

local function canSendGameInvite(targetPlayer)
	local res, canSend = pcall(SocialService.CanSendGameInviteAsync, SocialService, targetPlayer)
	return res and canSend
end

local function promptGameInvite(targetPlayer)
	local res, canInvite = pcall(SocialService.PromptGameInvite, SocialService, targetPlayer)
	return res and canInvite
end

local function openGameInvitePrompt(targetPlayer)
	local canInvite = canSendGameInvite(targetPlayer)
	if canInvite then
		invitedPlayers:FireServer()
		local promptOpened = promptGameInvite(targetPlayer)
		return promptOpened
	end
	return false
end

local function receiveNotification(Header, Caption, IconLink, Seconds)
	if Header and Caption then
		SG:SetCore("SendNotification", {
			Title = Header;
			Text = Caption;
			Icon = IconLink;
			Duration = Seconds
		})
	end
end

local function InvitePrompt(Header, Caption, B1, B2, IconLink, Seconds)
	local retrieveAnswer = Instance.new("BindableFunction")
	retrieveAnswer.OnInvoke = function(text)
		if text == "Yes" then
			openGameInvitePrompt(game.Players.LocalPlayer)
		end
	end

	if Header and Caption then
		SG:SetCore("SendNotification", {
			Title = Header;
			Text = Caption;
			Callback = retrieveAnswer;
			Button1 = B1;
			Button2 = B2;
			Icon = IconLink;
			Duration = Seconds
		})
	end
end

Notif.OnClientEvent:Connect(receiveNotification)

animalBux.Changed:Connect(function()
	local sign = "+"
	local delta = animalBux.Value - currentAnimalBux
	if delta < 0 then
		sign = "-"
	end
	
	delta = math.abs(delta)
	
	receiveNotification("Tokens", sign .. delta, "http://www.roblox.com/asset/?id=7146905518", 3)
	currentAnimalBux = animalBux.Value
end)

if inround.Value == false then
	if #(game.Players:GetChildren()) < 6 then
		InvitePrompt("Earn Tokens?", "Earn Tokens by inviting friends?", "Yes", "No", "http://www.roblox.com/asset/?id=7146905951", 10)
	end
end