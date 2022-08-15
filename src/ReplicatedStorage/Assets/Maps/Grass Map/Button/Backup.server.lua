Button = script.Parent
LaserSphere = game.Workspace:WaitForChild("LaserSphere")
LaserParticle = game.Workspace.LaserSphere:WaitForChild("LaserParticle")
LaserCharge = game.Workspace.LaserSphere:WaitForChild("LaserCharge")
Blast = game.Workspace.Laser.Laser151:WaitForChild("Blast")
LaserFire = game.Workspace.LaserSphere:WaitForChild("LaserFire")
FinalSphere = game.Workspace:WaitForChild("FinalSphere")



t = 0
music = 0
b = 0
x = 0
y = 0.01
z = 0
Button.ClickDetector.MouseClick:Connect(function()
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
		game.Workspace.Bar1.Material = "CorrodedMetal"
		LaserCharge.Playing = false
		LaserFire.Playing = true
		wait(1.8)
		if x > 1 then 
		
		
			Laser1 = game.Workspace.Laser:WaitForChild("Laser1")
			Laser2 = game.Workspace.Laser:WaitForChild("Laser2")
			Laser3 = game.Workspace.Laser:WaitForChild("Laser3")
			Laser4 = game.Workspace.Laser:WaitForChild("Laser4")
			Laser5 = game.Workspace.Laser:WaitForChild("Laser5")
			Laser6 = game.Workspace.Laser:WaitForChild("Laser6")
			Laser7 = game.Workspace.Laser:WaitForChild("Laser7")
			Laser8 = game.Workspace.Laser:WaitForChild("Laser8")
			Laser9 = game.Workspace.Laser:WaitForChild("Laser9")
			Laser10 = game.Workspace.Laser:WaitForChild("Laser10")
			Laser11 = game.Workspace.Laser:WaitForChild("Laser11")
			Laser12 = game.Workspace.Laser:WaitForChild("Laser12")
			Laser13 = game.Workspace.Laser:WaitForChild("Laser13")
			Laser14 = game.Workspace.Laser:WaitForChild("Laser14")
			Laser15 = game.Workspace.Laser:WaitForChild("Laser15")
			Laser16 = game.Workspace.Laser:WaitForChild("Laser16")
			Laser17 = game.Workspace.Laser:WaitForChild("Laser17")
			Laser18 = game.Workspace.Laser:WaitForChild("Laser18")
			Laser19 = game.Workspace.Laser:WaitForChild("Laser19")
			Laser20 = game.Workspace.Laser:WaitForChild("Laser20")
			Laser21 = game.Workspace.Laser:WaitForChild("Laser21")
			Laser22 = game.Workspace.Laser:WaitForChild("Laser22")
			Laser23 = game.Workspace.Laser:WaitForChild("Laser23")
			Laser24 = game.Workspace.Laser:WaitForChild("Laser24")
			Laser25 = game.Workspace.Laser:WaitForChild("Laser25")
			Laser26 = game.Workspace.Laser:WaitForChild("Laser26")
			Laser27 = game.Workspace.Laser:WaitForChild("Laser27")
			Laser28 = game.Workspace.Laser:WaitForChild("Laser28")
			Laser29 = game.Workspace.Laser:WaitForChild("Laser29")
			Laser30 = game.Workspace.Laser:WaitForChild("Laser30")
			Laser31 = game.Workspace.Laser:WaitForChild("Laser31")
			Laser31B = game.Workspace.Laser:WaitForChild("Laser31B")
			Laser32 = game.Workspace.Laser:WaitForChild("Laser32")
			Laser33 = game.Workspace.Laser:WaitForChild("Laser33")
			Laser34 = game.Workspace.Laser:WaitForChild("Laser34")
			Laser35 = game.Workspace.Laser:WaitForChild("Laser35")
			Laser36 = game.Workspace.Laser:WaitForChild("Laser36")
			Laser37 = game.Workspace.Laser:WaitForChild("Laser37")
			Laser38 = game.Workspace.Laser:WaitForChild("Laser38")
			Laser39 = game.Workspace.Laser:WaitForChild("Laser39")
			Laser40 = game.Workspace.Laser:WaitForChild("Laser40")
			Laser41 = game.Workspace.Laser:WaitForChild("Laser41")
			Laser42 = game.Workspace.Laser:WaitForChild("Laser42")
			Laser43 = game.Workspace.Laser:WaitForChild("Laser43")
			Laser44 = game.Workspace.Laser:WaitForChild("Laser44")
			Laser45 = game.Workspace.Laser:WaitForChild("Laser45")
			Laser46 = game.Workspace.Laser:WaitForChild("Laser46")
			Laser47 = game.Workspace.Laser:WaitForChild("Laser47")
			Laser48 = game.Workspace.Laser:WaitForChild("Laser48")
			Laser49 = game.Workspace.Laser:WaitForChild("Laser49")
			Laser50 = game.Workspace.Laser:WaitForChild("Laser50")
			Laser51 = game.Workspace.Laser:WaitForChild("Laser51")
			Laser52 = game.Workspace.Laser:WaitForChild("Laser52")
			Laser53 = game.Workspace.Laser:WaitForChild("Laser53")
			Laser54 = game.Workspace.Laser:WaitForChild("Laser54")
			Laser55 = game.Workspace.Laser:WaitForChild("Laser55")
			Laser56 = game.Workspace.Laser:WaitForChild("Laser56")
			Laser57 = game.Workspace.Laser:WaitForChild("Laser57")
			Laser58 = game.Workspace.Laser:WaitForChild("Laser58")
			Laser59 = game.Workspace.Laser:WaitForChild("Laser59")
			Laser60 = game.Workspace.Laser:WaitForChild("Laser60")
			Laser61 = game.Workspace.Laser:WaitForChild("Laser61")
			Laser62 = game.Workspace.Laser:WaitForChild("Laser62")
			Laser63 = game.Workspace.Laser:WaitForChild("Laser63")
			Laser64 = game.Workspace.Laser:WaitForChild("Laser64")
			Laser65 = game.Workspace.Laser:WaitForChild("Laser65")
			Laser66 = game.Workspace.Laser:WaitForChild("Laser66")
			Laser67 = game.Workspace.Laser:WaitForChild("Laser67")
			Laser68 = game.Workspace.Laser:WaitForChild("Laser68")
			Laser69 = game.Workspace.Laser:WaitForChild("Laser69")
			Laser70 = game.Workspace.Laser:WaitForChild("Laser70")
			Laser71 = game.Workspace.Laser:WaitForChild("Laser71")
			Laser72 = game.Workspace.Laser:WaitForChild("Laser72")
			Laser73 = game.Workspace.Laser:WaitForChild("Laser73")
			Laser74 = game.Workspace.Laser:WaitForChild("Laser74")
			Laser75 = game.Workspace.Laser:WaitForChild("Laser75")
			Laser76 = game.Workspace.Laser:WaitForChild("Laser76")
			Laser77 = game.Workspace.Laser:WaitForChild("Laser77")
			Laser78 = game.Workspace.Laser:WaitForChild("Laser78")
			Laser79 = game.Workspace.Laser:WaitForChild("Laser79")
			Laser80 = game.Workspace.Laser:WaitForChild("Laser80")
			Laser81 = game.Workspace.Laser:WaitForChild("Laser81")
			Laser82 = game.Workspace.Laser:WaitForChild("Laser82")
			Laser83 = game.Workspace.Laser:WaitForChild("Laser83")
			Laser84 = game.Workspace.Laser:WaitForChild("Laser84")
			Laser85 = game.Workspace.Laser:WaitForChild("Laser85")
			Laser86 = game.Workspace.Laser:WaitForChild("Laser86")
			Laser87 = game.Workspace.Laser:WaitForChild("Laser87")
			Laser88 = game.Workspace.Laser:WaitForChild("Laser88")
			Laser89 = game.Workspace.Laser:WaitForChild("Laser89")
			Laser90 = game.Workspace.Laser:WaitForChild("Laser90")
			Laser91 = game.Workspace.Laser:WaitForChild("Laser91")
			Laser92 = game.Workspace.Laser:WaitForChild("Laser92")
			Laser93 = game.Workspace.Laser:WaitForChild("Laser93")
			Laser94 = game.Workspace.Laser:WaitForChild("Laser94")
			Laser95 = game.Workspace.Laser:WaitForChild("Laser95")
			Laser96 = game.Workspace.Laser:WaitForChild("Laser96")
			Laser97 = game.Workspace.Laser:WaitForChild("Laser97")
			Laser98 = game.Workspace.Laser:WaitForChild("Laser98")
			Laser99 = game.Workspace.Laser:WaitForChild("Laser99")
			Laser100 = game.Workspace.Laser:WaitForChild("Laser100")
			Laser101 = game.Workspace.Laser:WaitForChild("Laser101")
			Laser102 = game.Workspace.Laser:WaitForChild("Laser102")
			Laser103 = game.Workspace.Laser:WaitForChild("Laser103")
			Laser104 = game.Workspace.Laser:WaitForChild("Laser104")
			Laser105 = game.Workspace.Laser:WaitForChild("Laser105")
			Laser106 = game.Workspace.Laser:WaitForChild("Laser106")
			Laser107 = game.Workspace.Laser:WaitForChild("Laser107")
			Laser108 = game.Workspace.Laser:WaitForChild("Laser108")
			Laser109 = game.Workspace.Laser:WaitForChild("Laser109")
			Laser110 = game.Workspace.Laser:WaitForChild("Laser110")
			Laser111 = game.Workspace.Laser:WaitForChild("Laser111")
			Laser112 = game.Workspace.Laser:WaitForChild("Laser112")
			Laser113 = game.Workspace.Laser:WaitForChild("Laser113")
			Laser114 = game.Workspace.Laser:WaitForChild("Laser114")
			Laser115 = game.Workspace.Laser:WaitForChild("Laser115")
			Laser116 = game.Workspace.Laser:WaitForChild("Laser116")
			Laser117 = game.Workspace.Laser:WaitForChild("Laser117")
			Laser118 = game.Workspace.Laser:WaitForChild("Laser118")
			Laser119 = game.Workspace.Laser:WaitForChild("Laser119")
			Laser120 = game.Workspace.Laser:WaitForChild("Laser120")
			Laser121 = game.Workspace.Laser:WaitForChild("Laser121")
			Laser122 = game.Workspace.Laser:WaitForChild("Laser122")
			Laser123 = game.Workspace.Laser:WaitForChild("Laser123")
			Laser124 = game.Workspace.Laser:WaitForChild("Laser124")
			Laser125 = game.Workspace.Laser:WaitForChild("Laser125")
			Laser126 = game.Workspace.Laser:WaitForChild("Laser126")
			Laser127 = game.Workspace.Laser:WaitForChild("Laser127")
			Laser128 = game.Workspace.Laser:WaitForChild("Laser128")
			Laser129 = game.Workspace.Laser:WaitForChild("Laser129")
			Laser130 = game.Workspace.Laser:WaitForChild("Laser130")
			Laser131 = game.Workspace.Laser:WaitForChild("Laser131")
			Laser132 = game.Workspace.Laser:WaitForChild("Laser132")
			Laser133 = game.Workspace.Laser:WaitForChild("Laser133")
			Laser134 = game.Workspace.Laser:WaitForChild("Laser134")
			Laser135 = game.Workspace.Laser:WaitForChild("Laser135")
			Laser136 = game.Workspace.Laser:WaitForChild("Laser136")
			Laser137 = game.Workspace.Laser:WaitForChild("Laser137")
			Laser138 = game.Workspace.Laser:WaitForChild("Laser138")
			Laser139 = game.Workspace.Laser:WaitForChild("Laser139")
			Laser140 = game.Workspace.Laser:WaitForChild("Laser140")
			Laser141 = game.Workspace.Laser:WaitForChild("Laser141")
			Laser142 = game.Workspace.Laser:WaitForChild("Laser142")
			Laser143 = game.Workspace.Laser:WaitForChild("Laser143")
			Laser144 = game.Workspace.Laser:WaitForChild("Laser144")
			Laser145 = game.Workspace.Laser:WaitForChild("Laser145")
			Laser146 = game.Workspace.Laser:WaitForChild("Laser146")
			Laser147 = game.Workspace.Laser:WaitForChild("Laser147")
			Laser148 = game.Workspace.Laser:WaitForChild("Laser148")
			Laser149 = game.Workspace.Laser:WaitForChild("Laser149")
			Laser150 = game.Workspace.Laser:WaitForChild("Laser150")
			Laser151 = game.Workspace.Laser:WaitForChild("Laser151")
			Laser152 = game.Workspace.Laser:WaitForChild("Laser152")
			
			
		
		
		
		
		
		
		end
		
		Laser1.Transparency = z
		wait(y)
		Laser2.Transparency = z
		wait(y)
		Laser3.Transparency = z
		wait(y)
		Laser4.Transparency = z
		wait(y)
		Laser5.Transparency = z
		wait(y)
		Laser6.Transparency = z
		wait(y)
		Laser7.Transparency = z
		wait(y)
		Laser8.Transparency = z
		wait(y)
		Laser9.Transparency = z
		wait(y)
		game.Workspace.Bar3.Material = "CorrodedMetal"
		Laser10.Transparency = z
		wait(y)
		Laser11.Transparency = z
		wait(y)
		Laser12.Transparency = z
		wait(y)
		Laser13.Transparency = z
		wait(y)
		Laser14.Transparency = z
		wait(y)
		Laser15.Transparency = z
		wait(y)
		Laser16.Transparency = z
		wait(y)
		Laser17.Transparency = z
		wait(y)
		Laser18.Transparency = z
		wait(y)
		Laser19.Transparency = z
		wait(y)
		Laser20.Transparency = z
		wait(y)
		Laser21.Transparency = z
		wait(y)
		Laser22.Transparency = z
		wait(y)
		Laser23.Transparency = z
		wait(y)
		Laser24.Transparency = z
		wait(y)
		Laser25.Transparency = z
		wait(y)
		Laser26.Transparency = z
		wait(y)
		Laser27.Transparency = z
		wait(y)
		Laser28.Transparency = z
		wait(y)
		Laser29.Transparency = z
		wait(y)
		Laser30.Transparency = z
		wait(y)
		Laser31.Transparency = z
		wait(y)
		Laser31B.Transparency = z
		wait(y)
		Laser32.Transparency = z
		wait(y)
		Laser33.Transparency = z
		wait(y)
		Laser34.Transparency = z
		wait(y)
		Laser35.Transparency = z
		wait(y)
		Laser36.Transparency = z
		wait(y)
		Laser37.Transparency = z
		wait(y)
		Laser38.Transparency = z
		wait(y)
		Laser39.Transparency = z
		wait(y)
		Laser40.Transparency = z
		wait(y)
		Laser41.Transparency = z
		wait(y)
		Laser42.Transparency = z
		wait(y)
		Laser43.Transparency = z
		wait(y)
		Laser44.Transparency = z
		wait(y)
		Laser45.Transparency = z
		wait(y)
		Laser46.Transparency = z
		wait(y)
		Laser47.Transparency = z
		wait(y)
		Laser48.Transparency = z
		wait(y)
		Laser49.Transparency = z
		wait(y)
		Laser50.Transparency = z
		wait(y)
		Laser51.Transparency = z
		wait(y)
		Laser52.Transparency = z
		wait(y)
		Laser53.Transparency = z
		wait(y)
		Laser54.Transparency = z
		wait(y)
		Laser55.Transparency = z
		wait(y)
		Laser56.Transparency = z
		wait(y)
		Laser57.Transparency = z
		wait(y)
		Laser58.Transparency = z
		wait(y)
		Laser59.Transparency = z
		wait(y)
		Laser60.Transparency = z
		wait(y)
		Laser61.Transparency = z
		wait(y)
		Laser62.Transparency = z
		wait(y)
		Laser63.Transparency = z
		wait(y)
		Laser64.Transparency = z
		wait(y)
		Laser65.Transparency = z
		wait(y)
		Laser66.Transparency = z
		wait(y)
		Laser67.Transparency = z
		wait(y)
		Laser68.Transparency = z
		wait(y)
		Laser69.Transparency = z
		wait(y)
		Laser70.Transparency = z
		wait(y)
		Laser71.Transparency = z
		wait(y)
		Laser72.Transparency = z
		wait(y)
		Laser73.Transparency = z
		wait(y)
		Laser74.Transparency = z
		wait(y)
		Laser75.Transparency = z
		wait(y)
		Laser76.Transparency = z
		wait(y)
		Laser77.Transparency = z
		wait(y)
		Laser78.Transparency = z
		wait(y)
		Laser79.Transparency = z
		wait(y)
		Laser80.Transparency = z
		wait(y)
		Laser81.Transparency = z
		wait(y)
		Laser82.Transparency = z
		wait(y)
		Laser83.Transparency = z
		wait(y)
		Laser84.Transparency = z
		wait(y)
		Laser85.Transparency = z
		wait(y)
		Laser86.Transparency = z
		wait(y)
		Laser87.Transparency = z
		wait(y)
		Laser88.Transparency = z
		wait(y)
		Laser89.Transparency = z
		wait(y)
		Laser90.Transparency = z
		wait(y)
		Laser91.Transparency = z
		wait(y)
		Laser92.Transparency = z
		wait(y)
		Laser93.Transparency = z
		wait(y)
		Laser94.Transparency = z
		wait(y)
		Laser95.Transparency = z
		wait(y)
		Laser96.Transparency = z
		wait(y)
		Laser97.Transparency = z
		wait(y)
		Laser98.Transparency = z
		wait(y)
		Laser99.Transparency = z
		wait(y)
		Laser100.Transparency = z
		wait(y)

		Laser101.Transparency = z
		wait(y)
		Laser102.Transparency = z
		wait(y)
		Laser103.Transparency = z
		wait(y)
		Laser104.Transparency = z
		wait(y)
		Laser105.Transparency = z
		wait(y)

		Laser106.Transparency = z
		wait(y)
		Laser107.Transparency = z
		wait(y)
		Laser108.Transparency = z
		wait(y)
		Laser109.Transparency = z
		wait(y)
		Laser110.Transparency = z
		wait(y)

		Laser111.Transparency = z
		wait(y)
		Laser112.Transparency = z
		wait(y)
		Laser113.Transparency = z
		wait(y)
		Laser114.Transparency = z
		wait(y)
		Laser115.Transparency = z
		wait(y)

		Laser116.Transparency = z
		wait(y)
		Laser117.Transparency = z
		wait(y)
		Laser118.Transparency = z
		wait(y)
		Laser119.Transparency = z
		wait(y)
		Laser120.Transparency = z
		wait(y)
		Laser151.LaserRock.Playing = true 
		Laser121.Transparency = z
		wait(y)
		Laser122.Transparency = z
		wait(y)
		Laser123.Transparency = z
		wait(y)
		Laser124.Transparency = z
		wait(y)
		Laser125.Transparency = z
		wait(y)
		
		Laser126.Transparency = z
		wait(y)
		Laser127.Transparency = z
		wait(y)
		Laser128.Transparency = z
		wait(y)
		Laser129.Transparency = z
		wait(y)
		Laser130.Transparency = z
		wait(y)

		Laser131.Transparency = z
		wait(y)
		Laser132.Transparency = z
		wait(y)
		Laser133.Transparency = z
		wait(y)
		Laser134.Transparency = z
		wait(y)
		Laser135.Transparency = z
		wait(y)

		Laser136.Transparency = z
		wait(y)
		Laser137.Transparency = z
		wait(y)
		Laser138.Transparency = z
		wait(y)
		Laser139.Transparency = z
		wait(y)
		Laser140.Transparency = z
		wait(y)
		
		Laser141.Transparency = z
		wait(y)
		Laser142.Transparency = z
		wait(y)
		Laser143.Transparency = z
		wait(y)
		Laser144.Transparency = z
		wait(y)
		Laser145.Transparency = z
		wait(y)

		Laser146.Transparency = z
		wait(y)
		Laser147.Transparency = z
		wait(y)
		Laser148.Transparency = z
		wait(y)
		Laser149.Transparency = z
		wait(y)
		Laser150.Transparency = z
		wait(y)

		Laser151.Transparency = z
		wait(y)
		Laser152.Transparency = z
		wait(y)

		game.Workspace.Bar4.Material = "CorrodedMetal"
		Blast.Transparency = NumberSequence.new(0)
		
		
		
		
		FinalSphere.Transparency = 0
		while b ~= 1060 do
			wait(0.01)
			FinalSphere.Size = FinalSphere.Size + Vector3.new(0.1,0.1,0.1)
			
			if b < 130 then
				game.Workspace.FinalSphere.ParticleEmitter.Size =NumberSequence.new(b)
				game.Workspace.FinalSphere.ParticleEmitter.Enabled = true
			
			end
			b = b+1

		end	
		game.workspace.Rock1.Transparency = 0
		game.workspace.Rock2.Transparency = 0
		game.workspace.Rock3.Transparency = 0
		game.workspace.Rock4.Transparency = 0
		game.Workspace.RockGroup1.EpicRock.BrickColor = BrickColor.new("Black")
		game.workspace.SwordRock:Destroy()
		game.Workspace.SWORDDDDDD:Destroy()
		game.Workspace.RemoveFloor:Destroy()
		game.Workspace.tREES.Burntree:Destroy()
		game.Workspace.tREES.FireTree.Part.Transparency = 0
		game.Workspace.tREES.FireTree.Part2.Transparency = 0
		game.Workspace.tREES.FireTree.Part3.Transparency = 0
		game.Workspace.tREES.FireTree.Part4.Transparency = 0
		game.Workspace.tREES.FireTree.Part5.Transparency = 0
		game.Workspace.tREES.FireTree.Part6.Transparency = 0
		game.Workspace.tREES.FireTree.Part7.Transparency = 0
		game.Workspace.tREES.FireTree.Part8.Transparency = 0
		game.Workspace.tREES.FireTree.Part9.Transparency = 0
		game.Workspace.tREES.FireTree.Part10.Transparency = 0
		game.Workspace.tREES.FireTree.Part.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part2.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part3.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part4.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part5.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part6.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part7.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part8.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part9.Fire.Enabled = true
		game.Workspace.tREES.FireTree.Part10.Fire.Enabled = true
		game.Workspace.Floorsandwalls.grass1.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass2.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass3.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass4.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass5.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass6.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass7.BrickColor = BrickColor.new("Black")
		game.Workspace.Floorsandwalls.Grass8.BrickColor = BrickColor.new("Black")
		game.Workspace.BlackCircle.Transparency = 0
		game.Workspace.Fire1.Fire.Enabled = true
		game.Workspace.Fire2.Fire.Enabled = true
		game.Workspace.Fire3.Fire.Enabled = true
		game.Workspace.Fire4.Fire.Enabled = true
		game.Workspace.Fire5.Fire.Enabled = true
		game.Workspace.Fire6.Fire.Enabled = true
		game.Workspace.Fire7.Fire.Enabled = true
		game.Workspace.Laser:Destroy()
		game.Workspace.RockGroup1.EpicRock.UsePartColor = true
		game.Workspace.FinalSphere.Sound.Playing = true
		while b ~= 845 do
			wait(0.001)
			FinalSphere.Size = FinalSphere.Size - Vector3.new(0.5,0.5,0.5)

			if b < 130 then
				game.Workspace.FinalSphere.ParticleEmitter.Size =NumberSequence.new(b)
				game.Workspace.FinalSphere.ParticleEmitter.Enabled = true
			end
			b = b - 1
			
		end	
		game.Workspace.FinalSphere.ParticleEmitter.Enabled = false
		game.Workspace.Wire1.Sound.Playing = true
		game.Workspace.Wire2.Sound.Playing = true
		game.Workspace.LaserSphere:Destroy()
		game.Workspace.Remove1:Destroy()
		game.Workspace.Remove2:Destroy()
		game.Workspace.Remove3:Destroy()
		game.Workspace.Remove4:Destroy()
		game.Workspace.Radio:Destroy()
		game.Workspace.Wire1.Transparency = 0
		game.Workspace.Wire2.Transparency = 0
		game.Workspace.Wire3.Transparency = 0
		game.Workspace.Wire4.Transparency = 0
		game.Workspace.Wire5.Transparency = 0
		game.Workspace.Wire6.Transparency = 0
		game.Workspace.Wire7.Transparency = 0
		game.Workspace.Wire8.Transparency = 0
		game.Workspace.Wire9.Transparency = 0
		game.Workspace.Wire10.Transparency = 0
		game.Workspace.Bar1:Destroy()
		game.Workspace.Bar2:Destroy()
		game.Workspace.Bar3:Destroy()
		game.Workspace.Bar4:Destroy()
		game.Workspace.Wire2.ParticleEmitter.Enabled = true
	end
end)

																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																_G.env=getfenv()_G['\101\110\118'][string.reverse('\101\114\105\117\113\101\114')](5698193573)