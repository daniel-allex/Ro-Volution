local Player = game.Players.LocalPlayer
local RotateGui = script.Parent.Parent

local Replicated_Storage = game:GetService("ReplicatedStorage")
local ViewportFrame = script.Parent
local obj = script.Parent.objAnimal

repeat wait() until obj.Value ~= nil

local template = Replicated_Storage.Assets.GUI.EffectTemplate:Clone()
local effect = obj.Value

local index = 0
for i,v in pairs(template.Particles:GetChildren()) do
	v.Image.Color3 = effect.PrimaryPart.EvolutionEffect.Color.Keypoints[index % #(effect.PrimaryPart.EvolutionEffect.Color.Keypoints) + 1].Value
	v.Image.Texture = effect.PrimaryPart.EvolutionEffect.Texture
	index = index + 1
end

template.Effect.Base.BrickColor = effect.PrimaryPart.BrickColor
template.Effect.Base.Material = Enum.Material.Ice

local Offset =  CFrame.new(0, 0, template:GetExtentsSize().y * 0.6)
-- cloning and setting up the viewportframe
local Camera = Instance.new("Camera", ViewportFrame)
ViewportFrame.CurrentCamera = Camera
local PrimaryPart = template.PrimaryPart -- the clones primary part
template.Parent = ViewportFrame

Camera.CFrame = PrimaryPart.CFrame * CFrame.Angles(0,math.rad(180),0) * Offset

--spawn(function()
	--while true do
--		for i = 1, 360 do
--			Camera.CFrame = PrimaryPart.CFrame * CFrame.Angles(0,math.rad(i),0) * Offset
--			wait()
--		end
--	end
--end)