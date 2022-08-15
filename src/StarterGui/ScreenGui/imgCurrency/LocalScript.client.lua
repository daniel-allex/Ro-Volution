local UserInputService = game:GetService("UserInputService")


wait(0.1)

if UserInputService.TouchEnabled then
	script.Parent.AnchorPoint = Vector2.new(0, 1)
	script.Parent.Position = UDim2.new(0.01, 0, 0.98, 0)

end


script.Parent.Size = UDim2.new(0.05, script.Parent.imgGold.AbsoluteSize.X + script.Parent.txtGold.TextBounds.X + script.Parent.imgBuy.AbsoluteSize.X, 0.06, 0)

script.Parent.txtGold.Changed:Connect(function()
	script.Parent.Size = UDim2.new(0.05, script.Parent.imgGold.AbsoluteSize.X + script.Parent.txtGold.TextBounds.X + script.Parent.imgBuy.AbsoluteSize.X, 0.06, 0)

end)