local Player = game.Players.LocalPlayer
local RotateGui = script.Parent.Parent

local Replicated_Storage = game:GetService("ReplicatedStorage")
local ViewportFrame = script.Parent
local obj = script.Parent.objAnimal 

repeat wait() until obj.Value ~= nil

local Clone = obj.Value:Clone() -- clones the child
local PrimaryPart = Clone.UpperTorso -- the clones primary part
--local maxDimension = (math.max(Clone:GetExtentsSize().X, Clone:GetExtentsSize().Y, Clone:GetExtentsSize().Z)) * 0.7
local Offset =  CFrame.new(0, -0.1, Clone:GetExtentsSize().Z * 0.5 + 4.5)
-- cloning and setting up the viewportframe
local Camera = Instance.new("Camera", ViewportFrame)
ViewportFrame.CurrentCamera = Camera
Clone.Parent = ViewportFrame

Camera.CFrame = PrimaryPart.CFrame * CFrame.Angles(0,math.rad(180),0) * Offset

--spawn(function()
	--while true do
--		for i = 1, 360 do
--			Camera.CFrame = PrimaryPart.CFrame * CFrame.Angles(0,math.rad(i),0) * Offset
--			wait()
--		end
--	end
--end)