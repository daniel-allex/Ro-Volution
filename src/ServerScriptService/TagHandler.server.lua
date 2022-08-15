-- Variables

local Players = game:GetService("Players")
local ScriptService = game:GetService("ServerScriptService")
local ChatService = require(ScriptService:WaitForChild("ChatServiceRunner").ChatService)
local marketplaceService = game:GetService("MarketplaceService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local developers = {
	[11742256] = true,
	[146661102] = true,
	[108251374] = true,
	[155946845] = true,
	[8886537] = true,
	[11816529] = true,
}

local moderators = {
	[1155069650] = true
}

ChatService.SpeakerAdded:Connect(function(SpeakerName) -- Wait for a speaker to be added to Chat
    if game.Players:FindFirstChild(SpeakerName) then -- Makes sure the speaker is a real player
		local player = game.Players:FindFirstChild(SpeakerName) -- Get the player Object 
        local Speaker = ChatService:GetSpeaker(SpeakerName) -- Getting the Speaker Object from ChatService

		if developers[player.UserId] then -- Add more IDs for Devs
			Speaker:SetExtraData("Tags", {{TagText = "DEV", TagColor = Color3.fromRGB(41, 182, 246)}})
           -- Speaker:SetExtraData("NameColor", Color3.fromRGB(255,0,0)) -- Set the name color to the tag color
		elseif moderators[player.UserId] then -- If player owns gamepass			
			Speaker:SetExtraData("Tags", {{TagText = "MOD", TagColor = Color3.fromRGB(239, 83, 80)}})
		elseif marketplaceService:UserOwnsGamePassAsync(player.UserId, replicatedStorage.Assets.Gamepasses.VIP.Value) then -- If player owns gamepass			
			Speaker:SetExtraData("Tags", {{TagText = "VIP", TagColor = Color3.fromRGB(251, 192, 45)}})
        end
    end
end)