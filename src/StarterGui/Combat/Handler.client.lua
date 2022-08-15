-- Services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local SoundService = game:GetService("SoundService")

-- Local Player
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local pHumanoid = character:WaitForChild("Humanoid")
local playerHRP = character:WaitForChild("HumanoidRootPart")

-- Statfile
local Statfile = ReplicatedStorage:WaitForChild("StatFile")

-- Variables for determining which basic attack to use
local leftAttackUsed = false
local atkdb = true
local timeSinceLeftAttack = 0
local minTime = 0.6
local punchCooldown = 3
local isChangingModel = false

-- Variables for stomp attacks
local stompLevel = Statfile:WaitForChild(player.Name).playerStats.stompLevel
local stompdb = true

-- Variables for tracking speed
local spedUp = false

-- Names and variables for context actions
local ACTION_ATTACK = "Attack"
local ACTION_STOMP = "Stomp"
local ACTION_SPRINT = "Sprint"
local atkButtonToggled = false
local sprintButtonToggled = false
local stompButtonToggled = false

-- Animations
local leftPunchAnim = Instance.new("Animation")
local rightPunchAnim = Instance.new("Animation")
local leftKickAnim = Instance.new("Animation")
local rightKickAnim = Instance.new("Animation")
local stompAnim = Instance.new("Animation")

-- Set animation IDs
leftPunchAnim.AnimationId = "http://www.roblox.com/asset/?id=5980979384"
rightPunchAnim.AnimationId = "http://www.roblox.com/asset/?id=5980981446"
leftKickAnim.AnimationId = "http://www.roblox.com/asset/?id=5980977252"
rightKickAnim.AnimationId = "http://www.roblox.com/asset/?id=5980975139"
stompAnim.AnimationId = "http://www.roblox.com/asset/?id=6073647348"

-- Events
local Events = ReplicatedStorage.Events
local IncreaseWalkspeed = Events.IncreaseWalkspeed
local DecreaseWalkspeed = Events.DecreaseWalkspeed
local Attack = Events.Attack
local Stomp = Events.Stomp
local modelChangeStart = Events.changeStarted

-- Abhay's player in front code. please look over it to make sure its correct
function getPlayerInFront()
	local closestPlayer
	local sizeMultiplier = pHumanoid.BodyWidthScale.Value
	local distance = 30 * math.max(1, 1.2*math.sqrt(sizeMultiplier-2)) --  max distance in studs

	-- Find the player that is in front and has the minimum distance from you
	for _, p in pairs(Players:GetChildren()) do
		if not isInFront(p) then
			continue
		else
			local dist = (p.Character.HumanoidRootPart.Position - playerHRP.Position).Magnitude
			if dist < distance then
				closestPlayer = p
				distance = dist
			end
		end
	end
	return closestPlayer
end

function isInFront(otherPlayer)
	-- Added to avoid errors
	local otherChar = otherPlayer.Character
	local otherCharHP = otherChar.Humanoid.Health
	if (otherChar and otherChar == nil) or (otherCharHP and otherCharHP <= 0) then
		return false
	end
	-- Direction the player is looking
	local looking = playerHRP.CFrame.LookVector
	-- Direction otherPlayer is front player
	local vector = (otherChar.HumanoidRootPart.Position - playerHRP.Position).unit
	-- Angle between player
	local angleBetween = math.acos(looking:Dot(vector))
	angleBetween = math.deg(angleBetween)
	-- Test if the angle is greater than threshold
	if angleBetween < 85 then
		return true
	end
	return false
end

 --handle mobile and pc inputs 
local function handleAction(actionName, inputState, inputObject)
	-- For handling attacks
	if actionName == ACTION_ATTACK and inputState == Enum.UserInputState.Begin and atkdb and not isChangingModel then
		atkdb = false
		punchCooldown = 0.6
		local playerEvo = Statfile:WaitForChild(player.Name).playerStats.evoLvl.Value
		local enemyEvo
		if (getPlayerInFront()~= nil) then
			local enemy = getPlayerInFront()
			enemyEvo = Statfile:WaitForChild(enemy.Name).playerStats.evoLvl.Value
		else
			enemyEvo = playerEvo + 1
		end
		if (timeSinceLeftAttack > minTime)then
			leftAttackUsed = false
		end
		if not leftAttackUsed then
			if enemyEvo < playerEvo then
				local leftKickAnimTrack = character:WaitForChild("Humanoid"):LoadAnimation(leftKickAnim)
				leftKickAnimTrack:Play()
				Attack:FireServer()
				leftKickAnimTrack.Stopped:Wait()
				leftKickAnimTrack:Stop()
			else
				local leftPunchAnimTrack = character:WaitForChild("Humanoid"):LoadAnimation(leftPunchAnim)
				leftPunchAnimTrack:Play()
				Attack:FireServer()
				leftPunchAnimTrack.Stopped:Wait()
				leftPunchAnimTrack:Stop()
			end
			-- Set conditions for next attack
			leftAttackUsed = true
			timeSinceLeftAttack = 0
			
		elseif leftAttackUsed and timeSinceLeftAttack < minTime then
			if enemyEvo < playerEvo then
				local rightKickAnimTrack = character:WaitForChild("Humanoid"):LoadAnimation(rightKickAnim)
				rightKickAnimTrack:Play()
				Attack:FireServer()
				rightKickAnimTrack.Stopped:Wait()
				rightKickAnimTrack:Stop()
			else
				local rightPunchAnimTrack = character:WaitForChild("Humanoid"):LoadAnimation(rightPunchAnim)
				rightPunchAnimTrack:Play()
				Attack:FireServer()
				rightPunchAnimTrack.Stopped:Wait()
				rightPunchAnimTrack:Stop()
			end
			-- Set conditions for next attack
			leftAttackUsed = false
			timeSinceLeftAttack = 100
		end
		
	elseif actionName == ACTION_STOMP and stompLevel.Value >= 15 and stompdb and inputState == Enum.UserInputState.Begin then
			stompdb = false
			print("This input was an attempted stomp")
			Stomp:FireServer()
			local stompAnimTrack = character:WaitForChild("Humanoid"):LoadAnimation(stompAnim)
			stompAnimTrack:Play()
			stompAnimTrack.Stopped:Wait()
			stompAnimTrack:Stop()
			stompdb = true

	elseif actionName == ACTION_SPRINT then
		print("This input was a sprint")
		local playerEvo = ReplicatedStorage.StatFile:WaitForChild(player.Name).playerStats.evoLvl
		if inputState == Enum.UserInputState.Begin and not spedUp then
			print("Sprint ON")
			spedUp = true
			if playerEvo.Value < 2 and ReplicatedStorage.RoundStatus.inRound.Value == true then
				spedUp = false
				return  
			end
			IncreaseWalkspeed:FireServer()
		elseif inputState == Enum.UserInputState.End or ((ReplicatedStorage.RoundStatus.inRound.Value == true and playerEvo.Value < 2) and spedUp == true) then
			print("Sprint OFF")
			DecreaseWalkspeed:FireServer()
			spedUp = false	
		end
	end
end

local function setUpMobileButton(ACTION_NAME)
	-- set image and then scale that
	local playerGui = Players[player.Name].PlayerGui
	local touchGui = playerGui.TouchGui.TouchControlFrame
	
	local minAxis = math.min(touchGui.AbsoluteSize.x, touchGui.AbsoluteSize.y)
	local isSmallScreen = minAxis <= 500
	local buttonSize = isSmallScreen and 70 or 120
	
	local button = Instance.new("ImageButton")
	button.Size = UDim2.new(0, buttonSize, 0, buttonSize)
	button.BackgroundTransparency = 1
	button.Parent = touchGui 
	button.Name = ACTION_NAME .. "Button"

	-- Reference
	-- isSmallScreen and UDim2.new(1, -(buttonSize*1.5-10), 1, -buttonSize - 20)
	--				  or UDim2.new(1, -(buttonSize*1.5-10), 1, -buttonSize * 1.75)
	
	if ACTION_NAME == ACTION_ATTACK then
		local pos = isSmallScreen and UDim2.new(1, -(buttonSize*1.5 - 10), 1, -buttonSize*2 - 20)
								   or UDim2.new(1, -(buttonSize*1.5 - 10), 1, -buttonSize * 2.75)
		button.Position = pos
		button.Image = "rbxassetid://6351617086" --waiting
		button.PressedImage = "rbxassetid://6350908679"
		 
	elseif ACTION_NAME == ACTION_SPRINT then
		local pos = isSmallScreen and UDim2.new(1, -(buttonSize*2.4), 1, -buttonSize - 20)
								   or UDim2.new(1, -(buttonSize*2.4), 1, -buttonSize * 1.75)
		button.Position = pos
		button.Image = "rbxassetid://6351690618" --waiting 6351690618 (new)    6351618443(old)
		button.PressedImage = "rbxassetid://6350908528"

	
	elseif ACTION_NAME == ACTION_STOMP then
		local pos = isSmallScreen and UDim2.new(1, -(buttonSize*2.4), 1, -buttonSize*2 - 20)
								   or UDim2.new(1, -(buttonSize*2.4), 1, -buttonSize * 2.75)
		button.Position = pos
		button.Image = "rbxassetid://6351698364" --6351698364 (new) 6350908313 (old)
		button.PressedImage = "rbxassetid://6351618981" --waiting http://www.roblox.com/asset/?id=6351618981

	end	
end

local function hideMobileButtons()
	local touchGui = Players[player.Name].PlayerGui.TouchGui.TouchControlFrame
	local buttons = touchGui:GetChildren()
	for _, button in ipairs(buttons) do
		if button.Name == ACTION_ATTACK.."Button" or button.Name == ACTION_SPRINT.."Button" or button.Name == ACTION_STOMP.."Button" then
			--button:Destroy()
			button.Visible = false
		end
	end
end


if UserInputService.TouchEnabled then
	local touchGui = Players[player.Name]:WaitForChild("PlayerGui"):WaitForChild("TouchGui").TouchControlFrame
	
	if #touchGui:GetChildren() < 3 then
		setUpMobileButton(ACTION_ATTACK)
		setUpMobileButton(ACTION_SPRINT)
		setUpMobileButton(ACTION_STOMP)
		print("Touchscreen-friendly buttons added.")
	end
	
	local buttons = touchGui:GetChildren()
	for _, button in ipairs(buttons) do
		if button.Name == ACTION_ATTACK.."Button" then
			button.InputBegan:Connect(function(inputObject)
				if inputObject.UserInputState ~= Enum.UserInputState.Begin or inputObject.UserInputType ~= Enum.UserInputType.Touch then
					return
				end
				handleAction(ACTION_ATTACK, inputObject.UserInputState, inputObject)
			end)
			
		elseif button.Name == ACTION_SPRINT.."Button" then
			button.InputBegan:Connect(function(inputObject)
				if inputObject.UserInputState ~= Enum.UserInputState.Begin or inputObject.UserInputType ~= Enum.UserInputType.Touch then
					return
				end
				handleAction(ACTION_SPRINT, inputObject.UserInputState, inputObject)
			end)
			button.InputChanged:Connect(function(inputObject)
				local point = inputObject.Position
				local size = button.AbsoluteSize
				local pos = button.AbsolutePosition
				if (point.X > pos.X *1.02 and point.X < pos.X * 0.98  + size.X and  point.Y > pos.Y*1.02 and point.Y < pos.Y* 0.98  + size.Y) then
					return
				else
					handleAction(ACTION_SPRINT, Enum.UserInputState.End, inputObject)
				end
				
			end)
			button.InputEnded:Connect(function(inputObject)
				handleAction(ACTION_SPRINT, inputObject.UserInputState, inputObject)
			end) 
			
		elseif button.Name == ACTION_STOMP.."Button" then
			button.InputBegan:Connect(function(inputObject)
				if inputObject.UserInputState ~= Enum.UserInputState.Begin or inputObject.UserInputType ~= Enum.UserInputType.Touch then
					return
				end
				handleAction(ACTION_STOMP, inputObject.UserInputState, inputObject)
			end) 
		end
	end
	
	ReplicatedStorage.StatFile[player.Name].playerStats.stompLevel.Changed:Connect(function()
		if stompLevel.Value < 15 then
			touchGui.StompButton.Visible = false
		else
			touchGui.StompButton.Visible = true
		end
	end)
	
end

-- Binding and unbinding actions for the player based on team
local touchGui

if UserInputService.TouchEnabled then
	touchGui = Players[player.Name].PlayerGui.TouchGui.TouchControlFrame
end

if ReplicatedStorage.RoundStatus.inRound.Value == false then
	ContextActionService:UnbindAction(ACTION_ATTACK)
	ContextActionService:UnbindAction(ACTION_STOMP)
	ContextActionService:UnbindAction(ACTION_SPRINT)
	if UserInputService.TouchEnabled then
		hideMobileButtons()
	end
	ContextActionService:BindAction(ACTION_SPRINT, handleAction, false, Enum.KeyCode.LeftShift)
	
	if UserInputService.TouchEnabled then
		touchGui.SprintButton.Visible = true
	end

	-- Set position of SoundListener
	SoundService:SetListener(Enum.ListenerType.ObjectPosition, player.Character or player.CharacterAdded:Wait())
	
elseif ReplicatedStorage.RoundStatus.inRound.Value then
	ContextActionService:UnbindAction(ACTION_SPRINT)
	if UserInputService.TouchEnabled then
		hideMobileButtons()
	end
	ContextActionService:BindAction(ACTION_SPRINT, handleAction, false, Enum.KeyCode.LeftShift)
	ContextActionService:BindAction(ACTION_ATTACK, handleAction, false, Enum.UserInputType.MouseButton1)
	ContextActionService:BindAction(ACTION_STOMP, handleAction, false, Enum.KeyCode.G)
	if UserInputService.TouchEnabled then
		touchGui.SprintButton.Visible = true
		touchGui.AttackButton.Visible = true
	end
	-- Set position of SoundListener
	SoundService:SetListener(Enum.ListenerType.ObjectPosition, player.Character or player.CharacterAdded:Wait())
end

ReplicatedStorage.RoundStatus.inRound.Changed:Connect(function()
	if ReplicatedStorage.RoundStatus.inRound.Value == false then
		ContextActionService:UnbindAction(ACTION_ATTACK)
		ContextActionService:UnbindAction(ACTION_SPRINT)
		ContextActionService:UnbindAction(ACTION_STOMP)
		if UserInputService.TouchEnabled then
			hideMobileButtons()
		end
		ContextActionService:BindAction(ACTION_SPRINT, handleAction, false, Enum.KeyCode.LeftShift)
		
		if UserInputService.TouchEnabled then
			touchGui.SprintButton.Visible = true
		end
		
		-- Set position of SoundListener
		SoundService:SetListener(Enum.ListenerType.ObjectPosition, player.Character or player.CharacterAdded:Wait())
		
	elseif ReplicatedStorage.RoundStatus.inRound.Value then
		ContextActionService:UnbindAction(ACTION_SPRINT)
		if UserInputService.TouchEnabled then
			hideMobileButtons()
		end
		ContextActionService:BindAction(ACTION_ATTACK, handleAction, false, Enum.UserInputType.MouseButton1)
		ContextActionService:BindAction(ACTION_SPRINT, handleAction, false, Enum.KeyCode.LeftShift)
		ContextActionService:BindAction(ACTION_STOMP, handleAction, false, Enum.KeyCode.G)
		if UserInputService.TouchEnabled then
			touchGui.SprintButton.Visible = true
			touchGui.AttackButton.Visible = true
		end
		-- Set position of SoundListener
		SoundService:SetListener(Enum.ListenerType.ObjectPosition, player.Character or player.CharacterAdded:Wait())
	end
end)

-- Keep track of time passed since left attack (if used)
RunService.Heartbeat:Connect(function(step)
	if leftAttackUsed and timeSinceLeftAttack >= 0 then
		timeSinceLeftAttack += step
	end
	if punchCooldown > 0 then
		punchCooldown -= step
	elseif punchCooldown <= 0 then
		atkdb = true
	end
end)

--[[
humanoid.Running:Connect(function(speed)
	if speed > 0 then
		print("Player is running")
	else
		print("Player has stopped")
	end
end)
]]

modelChangeStart.OnClientEvent:Connect(function()
	isChangingModel = true
	wait()
	isChangingModel = false
end)