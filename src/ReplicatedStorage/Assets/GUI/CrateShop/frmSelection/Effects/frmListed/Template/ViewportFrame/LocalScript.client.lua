local Player = game.Players.LocalPlayer
local RotateGui = script.Parent.Parent

local Replicated_Storage = game:GetService("ReplicatedStorage")
local ViewportFrame = script.Parent
local obj = script.Parent.objAnimal

repeat wait() until obj.Value ~= nil

local function GetCameraOffset(fov, targetSize)
	local x, y, z = targetSize.x, targetSize.y, targetSize.Z
	local maxSize = math.sqrt(x^2 + y^2 + z^2)
	local fac = math.tan(math.rad(fov)/2)

	local depth = 0.5*maxSize/fac

	return depth+maxSize/2
end

local function changeObj()
	local Clone = obj.Value:Clone() -- clones the child
	local PrimaryPart = Clone.PrimaryPart -- the clones primary part
	local camera = Instance.new("Camera", ViewportFrame)
	camera.FieldOfView = 1
	ViewportFrame.CurrentCamera = camera
	Clone:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-0.5, -0.4, -0.5).unit * 0.85 * GetCameraOffset(camera.FieldOfView, Clone:GetExtentsSize())) * CFrame.fromEulerAnglesXYZ(math.rad(-10), math.rad(-10), math.rad(10)))
	-- cloning and setting up the viewportframe
	Clone.Parent = ViewportFrame
	camera.CFrame = CFrame.new(Vector3.new(0,0,0), Vector3.new(-0.5, -0.4, -0.5))
	
end

changeObj()