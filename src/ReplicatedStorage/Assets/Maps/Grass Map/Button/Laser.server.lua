math.randomseed(tick())
local lasernum = 4
	--math.random(1,20)

if lasernum ~= 1 then
	script.Parent.Parent.Radio:Destroy()
	script.Parent.Parent.Steel1:Destroy()
	script.Parent.Parent.Steel2:Destroy()
	script.Parent.Parent.Steel3:Destroy()
	script.Parent.Parent.Remove1:Destroy()
	script.Parent.Parent.Remove2:Destroy()
	script.Parent.Parent.Remove3:Destroy()
	script.Parent.Parent.Remove4:Destroy()
	script.Parent.Parent.Circle:Destroy()
	script.Parent.Parent.Bar1:Destroy()
	script.Parent.Parent.Bar2:Destroy()
	script.Parent.Parent.Bar3:Destroy()
	script.Parent.Parent.Bar4:Destroy()
	script.Parent.Parent.Metal1.Transparency = 0
	script.Parent.Parent.Metal2.Transparency = 0
	script.Parent.Parent.Metal3.Transparency = 0
	script.Parent.Parent.Metal4.Transparency = 0
	script.Parent.Parent.Metal5.Transparency = 0
	script.Parent.Parent.Metal6.Transparency = 0
	script.Parent.Parent.Metal1.CanCollide = true
	script.Parent.Parent.Metal2.CanCollide = true
	script.Parent.Parent.Metal3.CanCollide = true
	script.Parent.Parent.Metal4.CanCollide = true
	script.Parent.Parent.Metal5.CanCollide = true
	script.Parent.Parent.Metal6.CanCollide = true
	script.Parent.Transparency = 1
	

	script.Parent.Parent.Wire1.CanCollide = false
	script.Parent.Parent.Wire2.CanCollide = false
	script.Parent.Parent.Wire3.CanCollide = false
	script.Parent.Parent.Wire4.CanCollide = false
	script.Parent.Parent.Wire5.CanCollide = false
	script.Parent.Parent.Wire6.CanCollide = false
	script.Parent.Parent.Wire7.CanCollide = false
	script.Parent.Parent.Wire8.CanCollide = false
	script.Parent.Parent.Wire9.CanCollide = false
	script.Parent.Parent.Wire10.CanCollide = false



	
	
	
	script.Parent:Destroy()
	
else 



local remoteEvent = game.ReplicatedStorage.Events.LaserEvent

--[[
local TweenService = game:GetService("TweenService")
local ClickDetector = script.Parent.ClickDetector
local Button = script.Parent
local LaserSphere = script.Parent.Parent:WaitForChild("LaserSphere")
local LaserParticle = script.Parent.Parent.LaserSphere:WaitForChild("LaserParticle")
local LaserCharge = script.Parent.Parent.LaserSphere:WaitForChild("LaserCharge")
local LaserFire = script.Parent.Parent.LaserSphere:WaitForChild("LaserFire")
local FinalSphere = script.Parent.Parent:WaitForChild("FinalSphere")

--Laser stuff
local LaserHit = script.Parent.Parent.Laser:WaitForChild("LaserHit")
local FullLaser = script.Parent.Parent.Laser:WaitForChild("FullLaser")
local LaserStart = script.Parent.Parent.Laser:WaitForChild("LaserStart")
local Blast = LaserHit:WaitForChild("Blast")
local endSize = FullLaser.Size
local endPosition = FullLaser.Position
local goal = {
	Size = endSize,
	Position = endPosition
}
local seconds = 3


local t = 0
local music = 0
local b = 0
local x = 0
local y = 0.01
local z = 0

local function activateLaser()
	if t == 0 then
		t = t+1
		Button.Sound.Playing = true
		Button.BrickColor = BrickColor.new("Really red")
		LaserSphere.Transparency = 0
		LaserParticle.Transparency = NumberSequence.new(0)
		LaserSphere.BrickColor = BrickColor.new("Really red") 
		LaserSphere.Material = ("Neon")
		while x ~= 500 do
			wait(0.02)
			LaserSphere.Size = LaserSphere.Size + Vector3.new(0.01,0.01,0.01)
			if x < 7 then
				LaserParticle.Size =NumberSequence.new(x)
				if music == 0 then 
					LaserCharge.Playing = true
				end
			end
			x = x+1

		end
		script.Parent.Parent.Bar1.Material = "CorrodedMetal"
		LaserCharge.Playing = false
		LaserFire.Playing = true
		wait(1.8)
		if x > 1 then 
			local tweenInfo = TweenInfo.new(seconds)
			local tween = TweenService:Create(LaserStart, tweenInfo, goal)
			LaserStart.Transparency = 0
			tween:Play()

		end

		script.Parent.Parent.Bar4.Material = "CorrodedMetal"

		wait(1.8)
		LaserHit.LaserRock:Play()

		wait(0.7)
		Blast.Transparency = NumberSequence.new(0)
		FinalSphere.Transparency = 0.1
		while b ~= 1060 do
			wait(0.01)
			FinalSphere.Size = FinalSphere.Size + Vector3.new(0.1,0.1,0.1)

			if b < 130 then
				script.Parent.Parent.FinalSphere.ParticleEmitter.Size =NumberSequence.new(b)
				script.Parent.Parent.FinalSphere.ParticleEmitter.Enabled = true

			end
			b = b+1

		end	
		script.Parent.Parent.Rock1.Transparency = 0
		script.Parent.Parent.Rock2.Transparency = 0
		script.Parent.Parent.Rock3.Transparency = 0
		script.Parent.Parent.Rock4.Transparency = 0
		script.Parent.Parent.RockGroup1.EpicRock.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.SwordRock:Destroy()
		script.Parent.Parent.SWORDDDDDD:Destroy()
		script.Parent.Parent.RemoveFloor:Destroy()
		script.Parent.Parent.tREES.Burntree:Destroy()
		script.Parent.Parent.tREES.FireTree.Part.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part2.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part3.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part4.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part5.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part6.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part7.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part8.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part9.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part10.Transparency = 0
		script.Parent.Parent.tREES.FireTree.Part.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part2.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part3.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part4.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part5.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part6.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part7.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part8.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part9.Fire.Enabled = true
		script.Parent.Parent.tREES.FireTree.Part10.Fire.Enabled = true
		script.Parent.Parent.Floorsandwalls.grass1.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass2.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass3.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass4.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass5.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass6.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass7.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Floorsandwalls.Grass8.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.BlackCircle.Transparency = 0
		script.Parent.Parent.Fire1.Fire.Enabled = true
		script.Parent.Parent.Fire2.Fire.Enabled = true
		script.Parent.Parent.Fire3.Fire.Enabled = true
		script.Parent.Parent.Fire4.Fire.Enabled = true
		script.Parent.Parent.Fire5.Fire.Enabled = true
		script.Parent.Parent.Fire6.Fire.Enabled = true
		script.Parent.Parent.Fire7.Fire.Enabled = true
		script.Parent.Parent.Laser:Destroy()
		script.Parent.Parent.RockGroup1.EpicRock.UsePartColor = true
		script.Parent.Parent.FinalSphere.Sound.Playing = true
		while b ~= 845 do
			wait(0.001)
			FinalSphere.Size = FinalSphere.Size - Vector3.new(0.5,0.5,0.5)

			if b < 1000 then
				script.Parent.Parent.FinalSphere.ParticleEmitter.Size =NumberSequence.new((b - 800)/2)
				script.Parent.Parent.FinalSphere.ParticleEmitter.Enabled = true
			end
			b = b - 1

		end	
		script.Parent.Parent.FinalSphere.ParticleEmitter.Enabled = false
		script.Parent.Parent.Wire1.Sound.Playing = true
		script.Parent.Parent.Wire2.Sound.Playing = true
		script.Parent.Parent.LaserSphere:Destroy()
		script.Parent.Parent.Remove1:Destroy()
		script.Parent.Parent.Remove2:Destroy()
		script.Parent.Parent.Remove3:Destroy()
		script.Parent.Parent.Remove4:Destroy()
		script.Parent.Parent.Radio:Destroy()
		script.Parent.Parent.Wire1.Transparency = 0
		script.Parent.Parent.Wire2.Transparency = 0
		script.Parent.Parent.Wire3.Transparency = 0
		script.Parent.Parent.Wire4.Transparency = 0
		script.Parent.Parent.Wire5.Transparency = 0
		script.Parent.Parent.Wire6.Transparency = 0
		script.Parent.Parent.Wire7.Transparency = 0
		script.Parent.Parent.Wire8.Transparency = 0
		script.Parent.Parent.Wire9.Transparency = 0
		script.Parent.Parent.Wire10.Transparency = 0
		script.Parent.Parent.Bar1:Destroy()
		script.Parent.Parent.Bar2:Destroy()
		script.Parent.Parent.Bar3:Destroy()
		script.Parent.Parent.Bar4:Destroy()
		script.Parent.Parent.Wire2.ParticleEmitter.Enabled = true
	end
end
--]]

t = 0


local function activateLaser()
	if t == 0 then
		t = t + 1
		print("IT WORKED")
		local TweenService = game:GetService("TweenService")
		local Button = script.Parent.Parent.Button
		local LaserSphere = script.Parent.Parent:WaitForChild("LaserSphere")
		local LaserParticle = script.Parent.Parent.LaserSphere:WaitForChild("LaserParticle")
		local LaserCharge = script.Parent.Parent.LaserSphere:WaitForChild("LaserCharge")
		local LaserFire = script.Parent.Parent.LaserSphere:WaitForChild("LaserFire")
		local FinalSphere = script.Parent.Parent:WaitForChild("FinalSphere")

		--Laser stuff
		local LaserHit = script.Parent.Parent:WaitForChild("LaserHit")
		local FullLaser = script.Parent.Parent:WaitForChild("FullLaser")
		local LaserStart = script.Parent.Parent:WaitForChild("LaserStart")
		local Blast = LaserHit:WaitForChild("Blast")
		local endSize = FullLaser.Size
		local endPosition = FullLaser.Position
		local goal = {
			Size = endSize,
			Position = endPosition
		}
		local seconds = 3


		local music = 0
		local b = 0
		local x = 0
		local y = 0.01
		local z = 0
		local lazerx = 0
		local lazery = 0
		local lazerz = 0
			print("hiii")
	
				Button.Sound.Playing = true
				Button.BrickColor = BrickColor.new("Really red")
				LaserSphere.Transparency = 0
				LaserParticle.Transparency = NumberSequence.new(0)
				LaserSphere.BrickColor = BrickColor.new("Really red") 
				LaserSphere.Material = ("Neon")
				while x ~= 250 do
					wait(0.02)
					LaserSphere.Size = Vector3.new(LaserSphere.Size.X + 0.02, LaserSphere.Size.Y + 0.02, LaserSphere.Size.Z + 0.02)
					if x < 7 then
						LaserParticle.Size =NumberSequence.new(x)
						if music == 0 then 
							LaserCharge.Playing = true
						end
					end
					x = x+1

				end
		script.Parent.Parent.Bar1.Material = "CorrodedMetal"
		LaserCharge.Playing = false
				LaserFire.Playing = true
wait(1.4)
				if x > 1 then 
					local tweenInfo = TweenInfo.new(seconds)
					local tween = TweenService:Create(LaserStart, tweenInfo, goal)
					LaserStart.Transparency = 0
					tween:Play()

				end

		script.Parent.Parent.Bar4.Material = "CorrodedMetal"

				wait(2.35)
				LaserHit.LaserRock:Play()

				wait(0.2)
				Blast.Transparency = NumberSequence.new(0)
				FinalSphere.Transparency = 0.1
				while b ~= 106 do
			wait(0.01)
			
					FinalSphere.Size = FinalSphere.Size + Vector3.new(1,1,1)

					if b < 130 then
				script.Parent.Parent.FinalSphere.ParticleEmitter.Size =NumberSequence.new(b)
				script.Parent.Parent.FinalSphere.ParticleEmitter.Enabled = true

					end
					b = b+1

				end	
		script.Parent.Parent.BlackCircle.Transparency = 0
				wait(2.5)		
		script.Parent.Parent.Rock1.Transparency = 0
		script.Parent.Parent.Rock2.Transparency = 0
		script.Parent.Parent.Rock3.Transparency = 0
		script.Parent.Parent.Rock4.Transparency = 0
		script.Parent.Parent.Rock1.CanCollide = true
		script.Parent.Parent.FinalSphere.ParticleEmitter:Destroy()
		script.Parent.Parent.Rock2.CanCollide = true
		script.Parent.Parent.Rock3.CanCollide = true
		script.Parent.Parent.Rock4.CanCollide = true
		script.Parent.Parent.EpicRock.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.SwordRock:Destroy()
		script.Parent.Parent.Sword1:Destroy()
		script.Parent.Parent.RemoveFloor:Destroy()
		script.Parent.Parent.Burntree:Destroy()
		script.Parent.Parent.FireTree.Part.Transparency = 0
		script.Parent.Parent.FireTree.Part2.Transparency = 0
		script.Parent.Parent.FireTree.Part.CanCollide = true
		script.Parent.Parent.FireTree.Part2.CanCollide = true
		script.Parent.Parent.FireTree.Part.Fire.Enabled = true
		script.Parent.Parent.FireTree.Part2.Fire.Enabled = true

		script.Parent.Parent.grass1.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass2.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass3.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass4.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass5.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass6.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass7.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Grass8.BrickColor = BrickColor.new("Black")
		script.Parent.Parent.Fire1.Fire.Enabled = true
		script.Parent.Parent.Fire3.Fire.Enabled = true
		script.Parent.Parent.Fire4.Fire.Enabled = true
		script.Parent.Parent.Fire5.Fire.Enabled = true
		script.Parent.Parent.Fire6.Fire.Enabled = true
		script.Parent.Parent.Fire7.Fire.Enabled = true 
		script.Parent.Parent.FullLaser:Destroy()
		script.Parent.Parent.LaserSphere:Destroy()
		script.Parent.Parent.LaserStart:Destroy()
		script.Parent.Parent.EpicRock.UsePartColor = true
		script.Parent.Parent.FinalSphere.Sound.Playing = true
		Blast:Destroy()
				while b ~= 321 do
					wait(0.01)
					FinalSphere.Size = FinalSphere.Size - Vector3.new(0.5,0.5,0.5)
					b = b + 1

				end	
		
		script.Parent.Parent.Wire1.Sound.Playing = true
		script.Parent.Parent.Wire2.Sound.Playing = true
				
		script.Parent.Parent.Remove1:Destroy()
		script.Parent.Parent.Remove2:Destroy()
		script.Parent.Parent.Remove3:Destroy()
		script.Parent.Parent.Remove4:Destroy()
		script.Parent.Parent.Radio:Destroy()
		script.Parent.Parent.Wire1.Transparency = 0
		script.Parent.Parent.Wire2.Transparency = 0
		script.Parent.Parent.Wire3.Transparency = 0
		script.Parent.Parent.Wire4.Transparency = 0
		script.Parent.Parent.Wire5.Transparency = 0
		script.Parent.Parent.Wire6.Transparency = 0
		script.Parent.Parent.Wire7.Transparency = 0
		script.Parent.Parent.Wire8.Transparency = 0
		script.Parent.Parent.Wire9.Transparency = 0
		script.Parent.Parent.Wire10.Transparency = 0
		script.Parent.Parent.Bar1:Destroy()
		script.Parent.Parent.Bar2:Destroy()
		script.Parent.Parent.Bar3:Destroy()
		script.Parent.Parent.Bar4:Destroy()
		script.Parent.Parent.Wire2.ParticleEmitter.Enabled = true
	end
end

remoteEvent.OnServerEvent:Connect(activateLaser)
end