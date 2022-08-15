 local censor = script.Parent --case sensitive
local animation = script:WaitForChild('Animation')

local IdleOne = script:WaitForChild("Idle1")
local humanoid = script.Parent.Parent.StarterCharacter:WaitForChild('Humanoid')
local dance = humanoid:LoadAnimation(animation)

local Idle1 = humanoid:LoadAnimation(IdleOne)


--Waits for player to touch sensor then changes Value to 2

censor.Touched:Connect(function()
	if script.Parent.Running.Value == false then
		script.Parent.Running.Value = true
		
		script.Parent.Value.Value = 1
		

	end	
end)