local queue = {"Each successful friend invite earns 300 Tokens!", "Joining the Ro-Volution group earns 800 Tokens!", "Have a lot of Tokens? Use them on crates to earn cool items!", "Like the game? Make sure to leave a thumbs up!", "Check the Ro-Volution group and the Discord for secret codes!"}
local delay = 300
local systemColor = Color3.new(0.309804, 0.764706, 0.968627)

local ReplicatedStorage = game.ReplicatedStorage
local SendSystemMessage = ReplicatedStorage.Events.SendSystemMessage

local StatFile = ReplicatedStorage.StatFile
local PlayerFolder = StatFile:WaitForChild(game.Players.LocalPlayer.Name)

local animalBux = PlayerFolder.statnumbers.animalBux

local currentAnimalBux = animalBux.Value

local function ReceiveSystemMessage(msg, color, timeDelay)
	wait(timeDelay)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = msg;
		Font = Enum.Font.SourceSansBold;
		Color = color;
		FontSize = Enum.FontSize.Size18;
	})
end

SendSystemMessage.OnClientEvent:Connect(ReceiveSystemMessage)

while true do
	ReceiveSystemMessage("[SYSTEM] " .. queue[1], systemColor, 0)
	table.insert(queue, queue[1])
	table.remove(queue, 1)
	wait(delay)
end