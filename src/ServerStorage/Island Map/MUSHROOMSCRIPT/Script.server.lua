local model = script.Parent.Parent.MUSHROOMS:GetChildren()
math.randomseed(tick())

local random = 0

for i,v in pairs(model) do
	random = math.random(1,20)
	if random == 1 then 
		v.TextureID = ""
		v.SpotLight.Enabled = true
	end
end