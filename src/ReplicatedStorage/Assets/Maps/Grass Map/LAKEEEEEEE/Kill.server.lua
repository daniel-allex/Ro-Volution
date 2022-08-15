script.Parent.Touched:Connect(function (part)
	if part.Parent:FindFirstChild("Humanoid") then
		part.Parent.Humanoid.Health = 0
	end
end)