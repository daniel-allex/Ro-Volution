local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Status = ReplicatedStorage:WaitForChild("RoundStatus"):WaitForChild("Status")

script.Parent.Text = Status.Value
script.Parent.Shadow.Text = Status.Value

Status.Changed:Connect(function()
	script.Parent.Text = Status.Value
	script.Parent.Shadow.Text = Status.Value
end)