local used = false
local RS = game:GetService("ReplicatedStorage")
local maxAge = 30

script.Parent.Touched:connect(function(p)
	if used == false then
		used = true
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
		if humanoid then
			if humanoid.Health > 0 and ((humanoid.Parent.Name == script.Parent.killedPlayer.Value and (tick() - script.Parent.timeStamp.Value >= 5)) or humanoid.Parent.Name ~= script.Parent.killedPlayer.Value) then
				script.Parent.Sound:Play()
				local stats = RS.StatFile:FindFirstChild(humanoid.Parent.Name).playerStats
				stats.evoLvl.Value = stats.evoLvl.Value + script.Parent.evoLvl.Value
				wait(0.2)
				script.Parent:Destroy()
			end
		end
		used = false
	end
end)

script.Parent.Age.Changed:Connect(function()
	if(script.Parent.Age.Value > maxAge) then
		script.Parent:Destroy()
	end
end)