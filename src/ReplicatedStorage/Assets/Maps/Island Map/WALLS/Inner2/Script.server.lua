script.Parent.Debounce.Changed:Connect(function()
	if script.Parent.Debounce.Value == false then
		wait(3)
		if script.Parent.Debounce.Value == false then
			for i,v in pairs(script.Parent:GetChildren()) do
				if v:IsA("Part") then
					v.Transparency = 1
				end
			end
		end
	end
end)