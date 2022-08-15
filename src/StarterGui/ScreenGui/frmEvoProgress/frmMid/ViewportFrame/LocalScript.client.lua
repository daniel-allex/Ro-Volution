local Player = game.Players.LocalPlayer
local Replicated_Storage = game:GetService("ReplicatedStorage")
local evoLine = Replicated_Storage.StatFile:WaitForChild(Player.Name).statnumbers.lastEquipped
local ViewportFrame = script.Parent

local Clone = Replicated_Storage.EvolutionLines[evoLine.Value]["2"]:Clone()
local PrimaryPart = Clone.UpperTorso -- the clones primary part
local Offset =  CFrame.new(0, -0.1, Clone:GetExtentsSize().Z * 0.5 + 4.5)
-- cloning and setting up the viewportframe
local Camera = Instance.new("Camera", ViewportFrame)
ViewportFrame.CurrentCamera = Camera
Clone.Parent = ViewportFrame

Camera.CFrame = PrimaryPart.CFrame * CFrame.Angles(0,math.rad(180),0) * Offset

game.ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	if game.ReplicatedStorage.RoundStatus.inRound.Value == true then
		Clone:Destroy()
		Clone = Replicated_Storage.EvolutionLines[evoLine.Value]["2"]:Clone()
		PrimaryPart = Clone.UpperTorso -- the clones primary part
		Offset =  CFrame.new(0, -0.1, Clone:GetExtentsSize().Z * 0.5 + 4.5)
		Clone.Parent = ViewportFrame

		Camera.CFrame = PrimaryPart.CFrame * CFrame.Angles(0,math.rad(180),0) * Offset
	end
end)