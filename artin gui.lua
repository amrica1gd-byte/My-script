-- LocalScript
-- مکان: StarterGui یا StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ACCENT = Color3.fromRGB(120, 80, 255)
local ACCENT2 = Color3.fromRGB(0, 190, 255)
local DARK = Color3.fromRGB(18, 18, 28)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArtinGuiSystem"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local function tween(obj, time, props, style, dir)
	local t = TweenService:Create(
		obj,
		TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function addGradient(parent, c1, c2, rot)
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(c1, c2)
	g.Rotation = rot or 45
	g.Parent = parent
	return g
end

local function addCorner(parent, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r)
	c.Parent = parent
	return c
end

local function addStroke(parent, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thickness
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end

-- ============================================
--  جدول کدهای اسکریپت (برای دکمه‌ها)
-- ============================================
local SCRIPT_CODES = {
	["Adidas anim R15"] = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/0dce59766c707c879a464a2ed00de724/raw/9d6002c34f4b0eb6010f69ae45b2370cca409cf7/Adidas%2520anim.Lua"))() end,
	["Back door scanner"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-LALOL-Hub-Backdoor-Scanner-Without-the-Hint-52003"))() end,
	["Best anti bang"] = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/c16862617c8079a6c69172d5fddc4e87/raw/3ecdd58296fef774008d9baafbdf15620d7c8b0d/Anti%2520bang"))() end,
	["Best bang"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Pwnmaster99s-Universal-Stuffs-205984"))() end,
	["Beter dance R15"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))() end,
	["Bypass chat by coolhack"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/script310"))() end,
	["C00L remote spy"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/RemoteEventCOOL"))() end,
	["Code door hack"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/scriptHack1"))() end,
	["Copy game"] = function()
		local Params = { RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/", SSI = "saveinstance" }
		local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
		local Options = {}
		synsaveinstance(Options)
	end,
	["Dex script"] = function() loadstring(game:HttpGet("https://github.com/FusionWTF/Dex-Explorer/releases/download/Beta/out.lua"))() end,
	["Fe dance R15"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gaze-emote-74592"))() end,
	["Fe dance R6"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FIREXDF/fe-roblox-animation/main/new-interface.lua"))() end,
	["Fe homelander"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/script96"))() end,
	["Fe zambia R6 server slide"] = function() loadstring(game:HttpGet("https://pastefy.app/JOWniO6o/raw"))("T.me/DeltaScripts") end,
	["Free game pass (dont work all game)"] = function()
		getgenv().Settings = {
			CopyButton = false, AutoButton = true, AutoInterval = 0.1,
			InstantPurchase = false, AutoMassPurchase = false, Debug = false,
		}
		loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/1aa22dd5449bbf0e268e3aa70280569b/raw/8d987b46d2019b99dfb1f56911d11bad6f8558ab/Script.Lua"))()
	end,
	["God mode (don't work all game)"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/script86"))() end,
	["Go to admin"] = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/OfficialCynatica/636bed3e9ba0088733feb986768f8015/raw"))() end,
	["Iran tower gui"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/script94"))() end,
	["Persian fly"] = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/18e83c759077de75cefae24326d2ffec/raw/0b23f8ccfce761b3c5affe33d4acadf01de4e94f/Fly%2520doble.Lua"))() end,
	["Pro click panel"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/script33"))() end,
	["Rc6 music"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ac6-Music-Vulnerability-25536"))() end,
	["Remote viewer by artin"] = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/1c327ffbeb8f17957ac73a521c59ad7b/raw/d86f449845bebed26267530e8184c3ffa795bc76/Remote%2520viewer.Lua"))() end,
	["Scp R6"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-SCP-096-GUI-UNIVERSIAL-41936"))() end,
	["Spider man gui"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/amrica1gd-byte/My-script/main/Spider%20man.Lua"))() end,
	["Ssdevil gui"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/markoopium9-ship-it/SSDEVIL626./main/SSDEVIL626"))() end,
	["Sskid gui"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Bye/refs/heads/main/Bye"))() end,
	["Super ring"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Super-ring1/refs/heads/main/Super%20ring"))() end,
	["Sword kill all (dont work all game)"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GUI-Sword-Kill-all-V6-47125"))() end,
	["Ultimate f3x panel"] = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/amrica1gd-byte/My-script/main/Ultimate%20artin%20f3x%20panel.Lua"))() end,
	["Wall hop"] = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Wall-hop-99778"))() end,
}

---------------------------------------------------------------------
-- GUI اصلی
---------------------------------------------------------------------
local function createMainGui()
	local main = Instance.new("Frame")
	main.Name = "MainFrame"
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.Position = UDim2.new(0.5, 0, 0.5, 0)
	main.Size = UDim2.new(0.75, 0, 0.7, 0)
	main.BackgroundColor3 = DARK
	main.BorderSizePixel = 0
	main.Parent = screenGui
	addCorner(main, 14)
	addStroke(main, ACCENT, 2)

	-- محدودیت اندازه برای موبایل و کامپیوتر
	local sizeLimit = Instance.new("UISizeConstraint")
	sizeLimit.MaxSize = Vector2.new(280, 320)
	sizeLimit.MinSize = Vector2.new(200, 200)
	sizeLimit.Parent = main

	local scale = Instance.new("UIScale")
	scale.Scale = 0
	scale.Parent = main

	-- هدر
	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundColor3 = Color3.new(1, 1, 1)
	header.BorderSizePixel = 0
	header.Parent = main
	addCorner(header, 14)
	addGradient(header, ACCENT, ACCENT2, 0)

	-- پر کننده: گوشه‌های پایین هدر را صاف می‌کند
	local filler = Instance.new("Frame")
	filler.Size = UDim2.new(1, 0, 0, 14)
	filler.Position = UDim2.new(0, 0, 1, -14)
	filler.BackgroundColor3 = Color3.new(1, 1, 1)
	filler.BorderSizePixel = 0
	filler.Parent = header
	addGradient(filler, ACCENT, ACCENT2, 0)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -50, 1, 0)
	title.Position = UDim2.new(0, 14, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "Artin gui"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = header

	-- دکمه بستن
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 26, 0, 26)
	closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
	closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 90)
	closeBtn.Text = "X"
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 16
	closeBtn.TextColor3 = Color3.new(1, 1, 1)
	closeBtn.AutoButtonColor = false
	closeBtn.Parent = header
	addCorner(closeBtn, 8)

	closeBtn.MouseButton1Click:Connect(function()
		local t = tween(scale, 0.4, { Scale = 0 }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		t.Completed:Wait()
		screenGui:Destroy()
	end)

	-- اسکرول فریم
	local scroll = Instance.new("ScrollingFrame")
	scroll.Name = "Buttons"
	scroll.Position = UDim2.new(0, 8, 0, 48)
	scroll.Size = UDim2.new(1, -16, 1, -56)
	scroll.BackgroundTransparency = 1
	scroll.BorderSizePixel = 0
	scroll.ScrollBarThickness = 5
	scroll.ScrollBarImageColor3 = ACCENT
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.Parent = main

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = scroll

	local pad = Instance.new("UIPadding")
	pad.PaddingRight = UDim.new(0, 8)
	pad.PaddingTop = UDim.new(0, 2)
	pad.PaddingBottom = UDim.new(0, 6)
	pad.Parent = scroll

	-- جعبه جست‌وجو
	local searchBox = Instance.new("TextBox")
	searchBox.Name = "ButtonSearch"
	searchBox.LayoutOrder = 0
	searchBox.Size = UDim2.new(1, 0, 0, 36)
	searchBox.BackgroundColor3 = Color3.fromRGB(34, 34, 52)
	searchBox.BorderSizePixel = 0
	searchBox.ClearTextOnFocus = false
	searchBox.PlaceholderText = "Search buttons..."
	searchBox.PlaceholderColor3 = Color3.fromRGB(155, 155, 175)
	searchBox.Text = ""
	searchBox.TextColor3 = Color3.new(1, 1, 1)
	searchBox.Font = Enum.Font.Gotham
	searchBox.TextSize = 13
	searchBox.TextXAlignment = Enum.TextXAlignment.Left
	searchBox.Parent = scroll
	addCorner(searchBox, 9)
	addStroke(searchBox, Color3.fromRGB(70, 70, 100), 1)

	local searchPadding = Instance.new("UIPadding")
	searchPadding.PaddingLeft = UDim.new(0, 11)
	searchPadding.PaddingRight = UDim.new(0, 8)
	searchPadding.Parent = searchBox

	-- پنل Music
	local musicSound = Instance.new("Sound")
	musicSound.Name = "ArtinMusic"
	musicSound.SoundId = "rbxassetid://95131770144654"
	musicSound.Volume = 1
	musicSound.Looped = true
	musicSound.Parent = screenGui

	local musicCard = Instance.new("Frame")
	musicCard.Name = "MusicPanel"
	musicCard.LayoutOrder = 1
	musicCard.Size = UDim2.new(1, 0, 0, 46)
	musicCard.BackgroundColor3 = Color3.fromRGB(34, 34, 52)
	musicCard.BorderSizePixel = 0
	musicCard.Parent = scroll
	addCorner(musicCard, 10)
	addStroke(musicCard, Color3.fromRGB(70, 70, 100), 1)

	local musicTitle = Instance.new("TextLabel")
	musicTitle.Name = "MusicTitle"
	musicTitle.Position = UDim2.new(0, 10, 0, 0)
	musicTitle.Size = UDim2.new(1, -76, 1, 0)
	musicTitle.BackgroundTransparency = 1
	musicTitle.Text = "Music"
	musicTitle.Font = Enum.Font.GothamBold
	musicTitle.TextSize = 14
	musicTitle.TextColor3 = Color3.new(1, 1, 1)
	musicTitle.TextXAlignment = Enum.TextXAlignment.Left
	musicTitle.Parent = musicCard

	local musicToggle = Instance.new("TextButton")
	musicToggle.Name = "MusicToggle"
	musicToggle.AnchorPoint = Vector2.new(1, 0.5)
	musicToggle.Position = UDim2.new(1, -10, 0.5, 0)
	musicToggle.Size = UDim2.new(0, 48, 0, 27)
	musicToggle.BackgroundColor3 = Color3.fromRGB(210, 55, 65)
	musicToggle.BorderSizePixel = 0
	musicToggle.Text = "OFF"
	musicToggle.Font = Enum.Font.GothamBold
	musicToggle.TextSize = 12
	musicToggle.TextColor3 = Color3.new(1, 1, 1)
	musicToggle.AutoButtonColor = false
	musicToggle.Parent = musicCard
	addCorner(musicToggle, 6)

	local musicOn = false
	musicToggle.MouseButton1Click:Connect(function()
		musicOn = not musicOn
		if musicOn then
			musicToggle.Text = "ON"
			musicToggle.BackgroundColor3 = Color3.fromRGB(45, 180, 95)
			musicSound:Play()
		else
			musicToggle.Text = "OFF"
			musicToggle.BackgroundColor3 = Color3.fromRGB(210, 55, 65)
			musicSound:Stop()
		end
	end)

	-- پنل Speed (کارکردی)
	local speedCard = Instance.new("Frame")
	speedCard.Name = "SpeedSliderPanel"
	speedCard.LayoutOrder = 2
	speedCard.Size = UDim2.new(1, 0, 0, 78)
	speedCard.BackgroundColor3 = Color3.fromRGB(34, 34, 52)
	speedCard.BorderSizePixel = 0
	speedCard.Parent = scroll
	addCorner(speedCard, 10)
	addStroke(speedCard, Color3.fromRGB(70, 70, 100), 1)

	local speedTitle = Instance.new("TextLabel")
	speedTitle.Name = "SpeedTitle"
	speedTitle.Position = UDim2.new(0, 10, 0, 6)
	speedTitle.Size = UDim2.new(0.6, 0, 0, 22)
	speedTitle.BackgroundTransparency = 1
	speedTitle.Text = "Speed"
	speedTitle.Font = Enum.Font.GothamBold
	speedTitle.TextSize = 15
	speedTitle.TextColor3 = Color3.new(1, 1, 1)
	speedTitle.TextXAlignment = Enum.TextXAlignment.Left
	speedTitle.Parent = speedCard

	local speedValue = Instance.new("TextLabel")
	speedValue.Name = "SpeedPercent"
	speedValue.Position = UDim2.new(1, -72, 0, 6)
	speedValue.Size = UDim2.new(0, 62, 0, 22)
	speedValue.BackgroundTransparency = 1
	speedValue.Text = "100%"
	speedValue.Font = Enum.Font.GothamBold
	speedValue.TextSize = 14
	speedValue.TextColor3 = ACCENT2
	speedValue.TextXAlignment = Enum.TextXAlignment.Right
	speedValue.Parent = speedCard

	local sliderTrack = Instance.new("TextButton")
	sliderTrack.Name = "SpeedSliderTrack"
	sliderTrack.Position = UDim2.new(0, 12, 0, 43)
	sliderTrack.Size = UDim2.new(1, -24, 0, 10)
	sliderTrack.BackgroundColor3 = Color3.fromRGB(58, 58, 78)
	sliderTrack.BorderSizePixel = 0
	sliderTrack.Text = ""
	sliderTrack.AutoButtonColor = false
	sliderTrack.Parent = speedCard
	addCorner(sliderTrack, 5)

	local speedPercent = 100
	local sliderAlpha = (speedPercent - 1) / 299

	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "Fill"
	sliderFill.Size = UDim2.new(sliderAlpha, 0, 1, 0)
	sliderFill.BackgroundColor3 = ACCENT
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderTrack
	addCorner(sliderFill, 5)

	local sliderKnob = Instance.new("Frame")
	sliderKnob.Name = "Knob"
	sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
	sliderKnob.Position = UDim2.new(sliderAlpha, 0, 0.5, 0)
	sliderKnob.Size = UDim2.new(0, 18, 0, 18)
	sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
	sliderKnob.BorderSizePixel = 0
	sliderKnob.ZIndex = 2
	sliderKnob.Parent = sliderTrack
	addCorner(sliderKnob, 9)
	addStroke(sliderKnob, ACCENT, 2)

	local sliderDragging = false

	-- ============================================
	--  اعمال سرعت روی Humanoid
	-- ============================================
	local function applySpeed()
		local char = player.Character
		if not char then return end
		local hum = char:FindFirstChildWhichIsA("Humanoid")
		if not hum then return end
		hum.WalkSpeed = 16 * (speedPercent / 100)
	end

	local function setSpeedFromX(screenX)
		local left = sliderTrack.AbsolutePosition.X
		local width = sliderTrack.AbsoluteSize.X
		if width <= 0 then return end

		local alpha = math.clamp((screenX - left) / width, 0, 1)
		speedPercent = math.clamp(math.floor(1 + alpha * 299 + 0.5), 1, 300)
		sliderAlpha = (speedPercent - 1) / 299

		speedValue.Text = tostring(speedPercent) .. "%"
		sliderFill.Size = UDim2.new(sliderAlpha, 0, 1, 0)
		sliderKnob.Position = UDim2.new(sliderAlpha, 0, 0.5, 0)
		applySpeed()
	end

	sliderTrack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = true
			setSpeedFromX(input.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if sliderDragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then
			setSpeedFromX(input.Position.X)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = false
		end
	end)

	-- پنل Infinity Jump (کارکردی)
	local infinityCard = Instance.new("Frame")
	infinityCard.Name = "InfinityJumpPanel"
	infinityCard.LayoutOrder = 3
	infinityCard.Size = UDim2.new(1, 0, 0, 46)
	infinityCard.BackgroundColor3 = Color3.fromRGB(34, 34, 52)
	infinityCard.BorderSizePixel = 0
	infinityCard.Parent = scroll
	addCorner(infinityCard, 10)
	addStroke(infinityCard, Color3.fromRGB(70, 70, 100), 1)

	local infinityTitle = Instance.new("TextLabel")
	infinityTitle.Name = "InfinityJumpTitle"
	infinityTitle.Position = UDim2.new(0, 10, 0, 0)
	infinityTitle.Size = UDim2.new(1, -76, 1, 0)
	infinityTitle.BackgroundTransparency = 1
	infinityTitle.Text = "Infinity jump"
	infinityTitle.Font = Enum.Font.GothamBold
	infinityTitle.TextSize = 14
	infinityTitle.TextColor3 = Color3.new(1, 1, 1)
	infinityTitle.TextXAlignment = Enum.TextXAlignment.Left
	infinityTitle.Parent = infinityCard

	local infinityToggle = Instance.new("TextButton")
	infinityToggle.Name = "InfinityJumpToggle"
	infinityToggle.AnchorPoint = Vector2.new(1, 0.5)
	infinityToggle.Position = UDim2.new(1, -10, 0.5, 0)
	infinityToggle.Size = UDim2.new(0, 48, 0, 27)
	infinityToggle.BackgroundColor3 = Color3.fromRGB(210, 55, 65)
	infinityToggle.BorderSizePixel = 0
	infinityToggle.Text = "OFF"
	infinityToggle.Font = Enum.Font.GothamBold
	infinityToggle.TextSize = 12
	infinityToggle.TextColor3 = Color3.new(1, 1, 1)
	infinityToggle.AutoButtonColor = false
	infinityToggle.Parent = infinityCard
	addCorner(infinityToggle, 6)

	local infinityEnabledVisual = false
	local infJumpConnection = nil
	local infJumpDebounce = false

	local function enableInfinityJump()
		if infJumpConnection then infJumpConnection:Disconnect() end
		infJumpConnection = UserInputService.JumpRequest:Connect(function()
			if infJumpDebounce then return end
			local char = player.Character
			if not char then return end
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if hum then
				infJumpDebounce = true
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
				task.wait(0.1)
				infJumpDebounce = false
			end
		end)
	end

	local function disableInfinityJump()
		if infJumpConnection then
			infJumpConnection:Disconnect()
			infJumpConnection = nil
		end
	end

	infinityToggle.MouseButton1Click:Connect(function()
		infinityEnabledVisual = not infinityEnabledVisual
		if infinityEnabledVisual then
			infinityToggle.Text = "ON"
			infinityToggle.BackgroundColor3 = Color3.fromRGB(45, 180, 95)
			enableInfinityJump()
		else
			infinityToggle.Text = "OFF"
			infinityToggle.BackgroundColor3 = Color3.fromRGB(210, 55, 65)
			disableInfinityJump()
		end
	end)

	player.CharacterAdded:Connect(function()
		if infinityEnabledVisual then
			task.wait(0.5)
			enableInfinityJump()
		end
		if speedPercent ~= 100 then
			task.wait(0.5)
			applySpeed()
		end
	end)

	local names = {
		"Rc6 music",
		"Back door scanner",
		"Best bang",
		"Scp R6",
		"Copy game",
		"Sword kill all (dont work all game)",
		"Super ring",
		"Ssdevil gui",
		"Sskid gui",
		"Ultimate f3x panel",
		"Free game pass (dont work all game)",
		"Go to admin",
		"Iran tower gui",
		"Spider man gui",
		"Persian fly",
		"Code door hack",
		"God mode (don't work all game)",
		"Fe homelander",
		"Pro click panel",
		"C00L remote spy",
		"Bypass chat by coolhack",
		"Remote viewer by artin",
		"Dex script",
		"Fe dance R15",
		"Beter dance R15",
		"Fe dance R6",
		"Best anti bang",
		"Adidas anim R15",
		"Fe zambia R6 server slide",
	}

	table.sort(names, function(a, b)
		local la, lb = string.lower(a), string.lower(b)
		if la == lb then
			return a < b
		end
		return la < lb
	end)

	local searchableButtons = {}

	for i, name in ipairs(names) do
		local btn = Instance.new("TextButton")
		btn.Name = name
		btn.LayoutOrder = i + 3
		btn.Size = UDim2.new(1, 0, 0, 38)
		btn.BackgroundColor3 = Color3.fromRGB(34, 34, 52)
		btn.AutoButtonColor = false
		btn.Text = name
		btn.Font = Enum.Font.GothamMedium
		btn.TextSize = 13
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.TextWrapped = true
		btn.Parent = scroll
		table.insert(searchableButtons, {object = btn, searchName = name})
		addCorner(btn, 10)
		local stroke = addStroke(btn, Color3.fromRGB(70, 70, 100), 1)

		btn.MouseEnter:Connect(function()
			tween(btn, 0.2, { BackgroundColor3 = Color3.fromRGB(55, 45, 105) })
			tween(stroke, 0.2, { Color = ACCENT })
		end)
		btn.MouseLeave:Connect(function()
			tween(btn, 0.2, { BackgroundColor3 = Color3.fromRGB(34, 34, 52) })
			tween(stroke, 0.2, { Color = Color3.fromRGB(70, 70, 100) })
		end)

		btn.MouseButton1Click:Connect(function()
			local original = btn.Size
			tween(btn, 0.08, { Size = UDim2.new(1, -8, 0, 34) })
			task.wait(0.08)
			tween(btn, 0.12, { Size = original }, Enum.EasingStyle.Back)

			local codeFunc = SCRIPT_CODES[name]
			if codeFunc then
				task.spawn(function()
					local ok, err = pcall(codeFunc)
					if not ok then
						pcall(function()
							game:GetService("StarterGui"):SetCore("SendNotification", {
								Title = "Artin gui",
								Text = "خطا در اجرای " .. name,
								Duration = 3,
							})
						end)
						warn("[Artin gui] Script error in " .. name .. ": " .. tostring(err))
					else
						pcall(function()
							game:GetService("StarterGui"):SetCore("SendNotification", {
								Title = "Artin gui",
								Text = name .. " اجرا شد",
								Duration = 2,
							})
						end)
					end
				end)
			end
		end)
	end

	table.insert(searchableButtons, {object = infinityCard, searchName = "Infinity jump"})
	table.insert(searchableButtons, {object = musicCard, searchName = "Music"})

	local function applyButtonSearch()
		local query = string.lower(searchBox.Text or "")
		query = string.gsub(query, "^%s+", "")
		query = string.gsub(query, "%s+$", "")
		local searching = query ~= ""

		speedCard.Visible = not searching
		for _, entry in ipairs(searchableButtons) do
			local fullName = string.lower(entry.searchName)
			entry.object.Visible = (not searching) or string.find(fullName, query, 1, true) ~= nil
		end
	end

	searchBox:GetPropertyChangedSignal("Text"):Connect(applyButtonSearch)
	applyButtonSearch()

	local minBtn = Instance.new("TextButton")
	minBtn.Name = "MinimizeButton"
	minBtn.Size = UDim2.new(0, 26, 0, 26)
	minBtn.Position = UDim2.new(1, -66, 0.5, -13)
	minBtn.BackgroundColor3 = Color3.fromRGB(255, 185, 50)
	minBtn.Text = "-"
	minBtn.Font = Enum.Font.GothamBold
	minBtn.TextSize = 18
	minBtn.TextColor3 = Color3.new(1, 1, 1)
	minBtn.AutoButtonColor = false
	minBtn.Parent = header
	addCorner(minBtn, 8)

	local collapsed = false
	local minBusy = false
	local EXPANDED_SIZE = main.Size
	local COLLAPSED_SIZE = UDim2.new(main.Size.X.Scale, main.Size.X.Offset, 0, header.Size.Y.Offset)

	minBtn.MouseButton1Click:Connect(function()
		if minBusy then return end
		minBusy = true

		if not collapsed then
			collapsed = true
			minBtn.Text = "+"
			main.ClipsDescendants = true
			sizeLimit.MinSize = Vector2.new(200, 0)
			local t = tween(main, 0.35, { Size = COLLAPSED_SIZE })
			t.Completed:Wait()
			scroll.Visible = false
			filler.Visible = false
		else
			collapsed = false
			minBtn.Text = "-"
			scroll.Visible = true
			task.delay(0.1, function()
				if not collapsed then
					filler.Visible = true
				end
			end)
			local t = tween(main, 0.35, { Size = EXPANDED_SIZE })
			t.Completed:Wait()
			sizeLimit.MinSize = Vector2.new(200, 200)
			main.ClipsDescendants = false
		end

		minBusy = false
	end)

	local dragging = false
	local dragStart, startPos

	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging
			and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)

	tween(scale, 0.7, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

---------------------------------------------------------------------
-- اینترو
---------------------------------------------------------------------
local intro = Instance.new("Frame")
intro.Name = "Intro"
intro.AnchorPoint = Vector2.new(0.5, 0.5)
intro.Position = UDim2.new(0.5, 0, 0.5, 0)
intro.Size = UDim2.new(0, 220, 0, 220)
intro.BackgroundColor3 = Color3.new(1, 1, 1)
intro.BorderSizePixel = 0
intro.Parent = screenGui
addCorner(intro, 20)
addGradient(intro, ACCENT, ACCENT2, 45)
addStroke(intro, Color3.new(1, 1, 1), 3)

local introScale = Instance.new("UIScale")
introScale.Scale = 0
introScale.Parent = intro

local introText = Instance.new("TextLabel")
introText.Size = UDim2.new(1, -20, 1, -20)
introText.Position = UDim2.new(0, 10, 0, 10)
introText.BackgroundTransparency = 1
introText.Text = "Created by artin"
introText.Font = Enum.Font.GothamBlack
introText.TextSize = 28
introText.TextWrapped = true
introText.TextColor3 = Color3.new(1, 1, 1)
introText.Parent = intro

task.spawn(function()
	tween(introScale, 0.6, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	task.wait(3)
	tween(intro, 2, { Rotation = 360 }, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	task.wait(2)
	local out = tween(intro, 0.6, { Rotation = 540 }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	tween(introScale, 0.6, { Scale = 0 }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	out.Completed:Wait()
	intro:Destroy()
	createMainGui()
end)