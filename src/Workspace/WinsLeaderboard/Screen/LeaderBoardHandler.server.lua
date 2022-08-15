local DataStoreService = game:GetService("DataStoreService")
local WinsLeaderBoard = DataStoreService:GetOrderedDataStore("WinsLeaderboardV3.2")
local Model = script.Parent.Parent.Statue.Template
local Base = script.Parent.Parent.Statue.Base

Model.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)

local function updateLeaderboard()
	local success, errorMessage = pcall(function()
		local Data = WinsLeaderBoard:GetSortedAsync(false, 8)
		local WinsPage = Data:GetCurrentPage()

		for rank, data in ipairs(WinsPage) do
			local userName = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			if not userName then
				print(data.key)
			end
			local name = userName
			local Wins = data.value
			if Wins == nil then
				Wins = 0
			end
			
			if rank == 1 then
				if script.Parent.Parent.Statue.UserId.Value ~= tonumber(data.key) then
					script.Parent.Parent.Statue.UserId.Value = tonumber(data.key)
					local humanoid = Model.Humanoid
					
					if Model:FindFirstChild("Shirt") then
						Model.Shirt:Destroy()
					end

					if Model:FindFirstChild("Pants") then
						Model.Pants:Destroy()
					end
					
					humanoid:RemoveAccessories()

					humanoid:ApplyDescription(game.Players:GetHumanoidDescriptionFromUserId(script.Parent.Parent.Statue.UserId.Value))
					local SizeValue = 3
					humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
					--humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
					if humanoid:FindFirstChild("BodyHeightScale") then
						humanoid.BodyHeightScale.Value = SizeValue
					end

					if humanoid:FindFirstChild("BodyWidthScale") then
						humanoid.BodyWidthScale.Value = SizeValue
					end

					if humanoid:FindFirstChild("BodyDepthScale") then
						humanoid.BodyDepthScale.Value = SizeValue
					end

					if humanoid:FindFirstChild("HeadScale") then
						humanoid.HeadScale.Value = SizeValue
					end					wait(1)
					Model:MoveTo(Base.Position)
				end
			end
			
			--print("LEADERBOARD: ".. Wins)
			local isOnLeaderboard = false
			
			for i, v in pairs(script.Parent.LeaderboardGUI.frmData:GetChildren()) do
				if v.Name ~= "UIGridLayout" and v.Name ~= "Template" then
					if v.Player.Text == name then
						print("LEADERBOARD: ".. v.Name .. " is on the leaderboard already")
						isOnLeaderboard = true
						break
					end
				end
			end
			
			if Wins and isOnLeaderboard == false then
				local newLbFrame = script.Parent.LeaderboardGUI.frmData.Template:Clone()
				newLbFrame.Player.Text = name
				newLbFrame.Wins.Text = Wins
				newLbFrame.Rank.Text = rank
				newLbFrame.Name = rank
				newLbFrame.Visible = true
				newLbFrame.Parent = script.Parent.LeaderboardGUI.frmData
			end
		end
	end)
	
	if not success then
		print(errorMessage)
	end
end

for _, frame in pairs(script.Parent.LeaderboardGUI.frmData:GetChildren()) do
	if frame.Name ~= "UIGridLayout" and frame.Name ~= "Template" then
		frame:Destroy()
	end
end

updateLeaderboard()

game.ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	if game.ReplicatedStorage.RoundStatus.inRound.Value == true then
		for _, Player in pairs(game.Players:GetPlayers()) do
			if Player and game.ReplicatedStorage.StatFile:FindFirstChild(Player.Name) then
				if Player.UserId > 100 then
					WinsLeaderBoard:SetAsync(Player.UserId, game.ReplicatedStorage.StatFile[Player.Name].statnumbers.Wins.Value)
				end
			end
		end
		
		for _, frame in pairs(script.Parent.LeaderboardGUI.frmData:GetChildren()) do
			if frame.Name ~= "UIGridLayout" and frame.Name ~= "Template" then
				frame:Destroy()
			end
		end

		updateLeaderboard()
	end
end)