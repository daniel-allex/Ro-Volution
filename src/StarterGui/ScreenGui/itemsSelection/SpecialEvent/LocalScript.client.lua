local whiteList = {11742256, 11816529, 138777139, 2861361, 2755588326} -- previously banned players
local getTokenRain = game.ReplicatedStorage.Events.getTokenRain

if table.find(whiteList, game.Players.LocalPlayer.UserId) ~= nil then
	script.Parent.Visible = true
end

script.Parent.MouseButton1Click:Connect(function()
	getTokenRain:FireServer()
end)