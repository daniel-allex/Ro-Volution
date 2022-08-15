
local animation = script.parent.Script:WaitForChild('Animation')

local IdleOne = script.Parent.Script:WaitForChild("Idle1")
local humanoid = script.Parent.Parent.StarterCharacter:WaitForChild('Humanoid')
local dance = humanoid:LoadAnimation(animation)
local Idle1 = humanoid:LoadAnimation(IdleOne)




dance:play()

dance.stopped:Wait()

script.Parent.Script.Disabled = false
while true do
	if script.Parent.Value.Value == 0 then
		Idle1:play()
		Idle1.stopped:wait()
		
		
		
	elseif script.Parent.Value.Value == 1 then
		dance:Play()

		
		dance.stopped:Wait()
		script.Parent.Value.Value = 0
		script.Parent.Running.Value = false

	end
end