local ContentProvider = game:GetService("ContentProvider")

local content = game:GetService("ReplicatedStorage"):WaitForChild("EvolutionLines"):GetChildren()

--if not game:IsLoaded() then
--	game.Loaded:Wait()
--end

ContentProvider:PreloadAsync(content)