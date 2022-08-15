local REGEN_RATE = 3/20 -- Regenerate this fraction of MaxHealth per second.
local REGEN_STEP = 1 -- Wait this long between each regeneration step.

--------------------------------------------------------------------------------

local Character = script.Parent
local Humanoid = Character:WaitForChild('Humanoid')

--------------------------------------------------------------------------------

while true do
	while Humanoid.Health < Humanoid.MaxHealth and Humanoid.Health > 0 do
		local playerFolder = game.ReplicatedStorage.StatFile:FindFirstChild(script.Parent.Name)
		if playerFolder then
			repeat wait() until (tick() - playerFolder.playerStats.lastHit.Value >= 3)

			local dt = wait(REGEN_STEP)
			local dh = dt*REGEN_RATE*Humanoid.MaxHealth
			if Humanoid.Health > 0 then
				Humanoid.Health = math.min(Humanoid.Health + dh, Humanoid.MaxHealth)
			end
		end
	end
	Humanoid.HealthChanged:Wait()
end