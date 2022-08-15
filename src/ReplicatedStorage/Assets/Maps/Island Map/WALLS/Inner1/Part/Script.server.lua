local sound = game.ReplicatedStorage.Assets.Audio.ForceField

script.Parent.Touched:Connect(function(p)
	
	local humanoid = p.Parent:FindFirstChild("Humanoid")
	
	if not humanoid then
		humanoid = p.Parent.Parent:FindFirstChild("Humanoid")
	end
	
	if humanoid and script.Parent.Parent.Debounce.Value == false then
		script.Parent.Parent.Debounce.Value = true
		humanoid.Health = humanoid.Health - 10
		local particle = Instance.new("Part")
		particle.Transparency = 1
		particle.CanCollide = false
		particle.Parent = script.Parent
		particle.Position = p.Position
		local soundClone = sound:Clone()
		soundClone.Parent = particle
		soundClone:Play()

		for i,v in pairs(script.Parent.Parent:GetChildren()) do
			if v:IsA("Part") then
				v.Transparency = 0.5
			end
		end
		script.Parent.Parent.Debounce.Value = false

		soundClone.Ended:Wait()
		wait(0.2)
		particle:Destroy()
	end
end)