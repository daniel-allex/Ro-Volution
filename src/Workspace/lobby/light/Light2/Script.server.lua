math.randomseed(tick())
--[[
50 %255, 255, 97
15% 99, 99, 69
5%75, 75, 60
10% 94, 94, 50
9.9 130,  109, 26
0.1% 255, 0, 0
99 95 98


off
1 long blink
2 blink
3 blink
1 short blink

]]--
wait(1)
local y = 1
local x = 0
local times = 0
local time2 = 0
local u = 0
local a = 0
local b = 0
local c = 0
local e = 0
local f = 0
local g = 0
local h = 0
local m = 0
local i = 0
local t = 0
local array = {e,f,g,h,i}
local function flicker()
	m = math.random(1,2)

	script.Parent.Color = Color3.new(a, b, c)
	script.Parent.Parent.Light1.Color = Color3.new(a, b, c)
	script.Parent.Parent.Light3.Color = Color3.new(a, b, c)

	script.Parent.BrickColor = BrickColor.new(d)
	script.Parent.Parent.Light1.BrickColor = BrickColor.new(d)
	script.Parent.Parent.Light3.BrickColor=BrickColor.new(d)
	if m == 1 then
		script.Parent.Sound.Playing = true
		
	elseif m == 2 then
		script.Parent.Parent.Light1.Sound.Playing = true
	
	end
wait(time2*u)
script.Parent.Parent.Light1.Sound.Playing = false
script.Parent.Sound.Playing = false
	script.Parent.Color = Color3.new(99, 95, 98)
	script.Parent.Parent.Light1.Color = Color3.new(99,95,98)
	script.Parent.Parent.Light3.Color = Color3.new(99, 95, 98)	

	script.Parent.BrickColor = BrickColor.new("Dark stone grey")
	script.Parent.Parent.Light1.BrickColor = BrickColor.new("Dark stone grey")
	script.Parent.Parent.Light3.BrickColor=BrickColor.new("Dark stone grey")
	wait(time2/3)
end
while y == 1 do
	x = math.random(1,1000)
	times = (math.random(1000,5000))/1000
	time2 = (math.random(100,600))/1000
	array = {e,f,g,h,i}
	wait(0.5)
	array[1] = math.random(1,5)
	array[2] = math.random(1,5)
	array[3] = math.random(1,5)
	array[4] = math.random(1,5)
	array[5] = math.random(1,5)
	a = 255
	b = 0
	c = 0
	e = 0
	f = 0
	g = 0
	h = 0
	i = 0
	t = 0
	wait(0.5)
	if x == 1 then
		a = 255
		b = 0
		c = 0
		d = "Really red"
	elseif x > 1 and x < 100 then
		a = 160
		b = 132
		c = 79
		d = "Fawn brown"
	elseif x >= 100 and x < 200 then 
		a = 93
		b = 155
		c = 188
		d = "Cork"
	elseif x >= 200 and x < 250 then
		a = 75
		b = 75
		c = 60
		d = "Dark taupe"
	elseif x >= 250 and x < 450 then
		a = 99
		b = 99
		c = 69
		d = "Earth yellow"
	else
		a = 255
		b = 255
		c = 97
		d = "Daisy orange"
		
	end 
	
	while t < 5 do
		
		g = array[1] 
		if g == 1 then
			
			wait(time2*4)
			
		elseif g == 2 then
			u = 3
			flicker()
		elseif g == 3 then
			u = 1
			flicker()
			flicker()
		elseif g == 4 then 
			u = 1
			flicker()
			flicker()
			flicker()
		else
			u  = 1
			flicker()
		end
		t = t + 1
		wait(times)
		table.remove(array, 1)
		
	end
	
	
	
	
	
	
	
	
	
end



