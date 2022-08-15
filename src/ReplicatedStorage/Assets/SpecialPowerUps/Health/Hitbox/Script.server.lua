local used = false
local RS = game:GetService("ReplicatedStorage")
local maxAge = 30

script.Parent.Touched:connect(function(p)

	if used == false then
		local humanoid
		local find = p.Parent:FindFirstChild("Humanoid")
		if find
		then humanoid = find
		else
			find = p.Parent.Parent:FindFirstChild("Humanoid")
			if find then
				humanoid = find
			end
		end
		if humanoid and humanoid.Health > 0 then
			used = true
			script.Parent.Sound:Play()
			humanoid.Health = humanoid.Health + 60
			wait(0.2)
			script.Parent:Destroy()
		end
	end
end)

script.Parent.Age.Changed:Connect(function()
	if(script.Parent.Age.Value > maxAge) then
		script.Parent:Destroy()
	end
end)