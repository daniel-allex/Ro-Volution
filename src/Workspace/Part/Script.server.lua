local debounce = false
local StatFile = game.ReplicatedStorage.StatFile
local spawns = workspace.lobby.Spawns
local obbySpawns = {}
local lastPlr = ""
local lastTime = tick()

for i,v in pairs(spawns:GetChildren()) do
	if v.Name == "ObbyStart" then
		table.insert(obbySpawns, v)
	end
end

script.Parent.Touched:Connect(function(p)
	local humanoid = p.Parent:FindFirstChild("Humanoid")
	if not humanoid then
		humanoid = p.Parent.Parent:FindFirstChild("Humanoid")
	end
	
	if humanoid then
		if debounce == false and (lastPlr ~= humanoid.Parent.Name or tick() - lastTime > 5) then
			debounce = true
			lastPlr = humanoid.Parent.Name
			lastTime = tick()
			local playerFolder = StatFile:FindFirstChild(humanoid.Parent.Name)

			if playerFolder then
				local randSpawn = obbySpawns[math.random(#obbySpawns)]
				humanoid.Parent:MoveTo(randSpawn.Position)
				playerFolder.statnumbers.animalBux.Value = playerFolder.statnumbers.animalBux.Value + 50
			end
			debounce = false
		end
	end
end)