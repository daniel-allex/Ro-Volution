
local animation = script.parent.Script:WaitForChild('Animation')

local IdleOne = script.Parent.Script:WaitForChild("Idle1")
local humanoid = script.Parent.Parent.StarterCharacter:WaitForChild('Humanoid')
local dance = humanoid:LoadAnimation(animation)
local Idle1 = humanoid:LoadAnimation(IdleOne)

local function setAnimations()
	if script.Parent.Value.Value == 0 then
		Idle1:Play()
		Idle1.Stopped:Wait()
		if script.parent.Value.Value == 2 then 

		else
			script.Parent.Value.Value = 1
		end

	elseif script.Parent.Value.Value == 1 then
		Idle1:Play()
		Idle1.Stopped:Wait()
		if script.parent.Value.Value == 2 then 

		else
			script.Parent.Value.Value = 0
		end

	elseif script.Parent.Value.Value == 2 then
		wait(3)
		dance.Stopped:Wait()
		script.Parent.Value.Value = 0

	end
end

script.Parent.Value.Changed:Connect(function()
	print("Test")
	setAnimations()
end)