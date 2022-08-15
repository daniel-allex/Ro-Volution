wait(0.1)
script.Parent.Size = UDim2.new(0.15, 1.5 * script.Parent.imgGold.AbsoluteSize.X + script.Parent.txtGold.TextBounds.X, 0.7, 0)

script.Parent.txtGold.Changed:Connect(function()
script.Parent.Size = UDim2.new(0.15, 1.5 * script.Parent.imgGold.AbsoluteSize.X + script.Parent.txtGold.TextBounds.X, 0.7, 0)

end)