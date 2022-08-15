local SoundService = game:GetService("SoundService")
local Audio = game.ReplicatedStorage.Assets.Audio
local hover = Audio.Hover
local select = Audio.Select
local index = script.Parent.Parent.Parent.Parent.Index
local playerFolder = game.ReplicatedStorage.StatFile:WaitForChild(game.Players.LocalPlayer.Name)
local animalBux = playerFolder.statnumbers.animalBux
local firstTimePlaying = playerFolder.statnumbers.firstTimePlaying
local firstDailyReward = playerFolder.statnumbers.firstDailyReward
local specialMode = false
local woodCrateCost = 1200
local Crates = script.Parent.Parent.Parent.Parent:WaitForChild("CrateShop")

local function startTutorial()
	specialMode = true
	script.Parent.Parent.imgBackground.Image = "http://www.roblox.com/asset/?id=6384476130"
end

local function endTutorial()
	script.Parent.Parent.imgBackground.Image = "http://www.roblox.com/asset/?id=6312881673"
	specialMode = false
end

if firstTimePlaying.Value == true then
	if animalBux.Value >= woodCrateCost then
		Crates.specialMode.Value = true
		startTutorial()
	else
		if specialMode then
			Crates.specialMode.Value = false
			if firstDailyReward.Value == false then
				endTutorial()
			end
		end
	end
	
	
	animalBux.Changed:Connect(function()
		if firstTimePlaying.Value == true and animalBux.Value >= woodCrateCost then
			Crates.specialMode.Value = true
			startTutorial()
		else
			if specialMode then
				Crates.specialMode.Value = false
				if firstDailyReward.Value == false then
					endTutorial()
				end
			end
		end
	end)

	firstTimePlaying.Changed:Connect(function()
		if firstTimePlaying.Value == true and animalBux.Value >= woodCrateCost then
			Crates.specialMode.Value = true
			startTutorial()
		else
			if specialMode then
				Crates.specialMode.Value = false
				if firstDailyReward.Value == false then
					endTutorial()
				end
			end
		end
	end)
	
end

if firstDailyReward.Value == true then
	startTutorial()
	
	firstDailyReward.Changed:Connect(function()
		if firstDailyReward.Value == true then
			startTutorial()
		else
			if specialMode then
				if firstTimePlaying.Value == false or animalBux.Value < woodCrateCost then
					endTutorial()
					Crates.specialMode.Value = false
				end
			end
		end
	end)
end

local function hoverButton(btn)
	if specialMode then
		btn.imgBackground.Image = "http://www.roblox.com/asset/?id=6384508381"
	else
		btn.imgBackground.Image = "http://www.roblox.com/asset/?id=6312884157"
	end
	SoundService:PlayLocalSound(hover)
end

local function unhoverButton(btn)
	if specialMode then
		btn.imgBackground.Image = "http://www.roblox.com/asset/?id=6384476130"
	else
		btn.imgBackground.Image = "http://www.roblox.com/asset/?id=6312881673"
	end
end

script.Parent.MouseEnter:Connect(function()
	hoverButton(script.Parent.Parent)
end)

script.Parent.MouseLeave:Connect(function()
	unhoverButton(script.Parent.Parent)
end)

script.Parent.MouseButton1Click:Connect(function()
	if index.Value ~= "Locked" then
		if index.Value == "CrateShop" then
			index.Value = "Home"
		else
			index.Value = "CrateShop"
			if script.Parent.Parent.Parent.Parent.CrateShop.frmHeader.Selected.Value == "Effects" then
				script.Parent.Parent.Parent.Parent.CrateShop.NoCratesLabel.Visible = false
			end
		end
	end

	SoundService:PlayLocalSound(select)

end)