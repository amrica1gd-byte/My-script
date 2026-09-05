-- ============================================
-- Epic Animated Loading Screen + F3x admin GUI
-- ترکیب لودینگ و منوی چیت
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================
-- ساخت ScreenGui لودینگ
-- ============================================
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "EpicLoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 999
loadingGui.Parent = playerGui

local bg = Instance.new("Frame")
bg.Name = "Background"
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 14, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 14)),
})
bgGradient.Rotation = 90
bgGradient.Parent = bg

-- ============================================
-- ذرات شناور
-- ============================================
local particlesFolder = Instance.new("Frame")
particlesFolder.Name = "Particles"
particlesFolder.Size = UDim2.new(1, 0, 1, 0)
particlesFolder.BackgroundTransparency = 1
particlesFolder.ZIndex = 1
particlesFolder.Parent = bg

local function spawnParticle()
	local size = math.random(3, 7)
	local dot = Instance.new("Frame")
	dot.Size = UDim2.new(0, size, 0, size)
	dot.Position = UDim2.new(math.random(), 0, 1.05, 0)
	dot.BackgroundColor3 = Color3.fromRGB(120, 160, 255)
	dot.BackgroundTransparency = 0.4 + math.random() * 0.4
	dot.BorderSizePixel = 0
	dot.ZIndex = 1
	dot.Parent = particlesFolder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = dot

	local targetY = -0.1
	local duration = 3 + math.random() * 2.5

	local tween = TweenService:Create(dot, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Position = UDim2.new(dot.Position.X.Scale + (math.random() - 0.5) * 0.15, 0, targetY, 0),
		BackgroundTransparency = 1,
	})
	tween:Play()
	tween.Completed:Connect(function()
		dot:Destroy()
	end)
end

local particleSpawner = task.spawn(function()
	while true do
		spawnParticle()
		task.wait(0.12)
	end
end)

-- ============================================
-- لوگوی مرکزی (چرخان)
-- ============================================
local logoContainer = Instance.new("Frame")
logoContainer.Size = UDim2.new(0, 160, 0, 160)
logoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
logoContainer.Position = UDim2.new(0.5, 0, 0.38, 0)
logoContainer.BackgroundTransparency = 1
logoContainer.ZIndex = 3
logoContainer.Parent = bg

local outerRing = Instance.new("Frame")
outerRing.Size = UDim2.new(1, 0, 1, 0)
outerRing.AnchorPoint = Vector2.new(0.5, 0.5)
outerRing.Position = UDim2.new(0.5, 0, 0.5, 0)
outerRing.BackgroundTransparency = 1
outerRing.ZIndex = 3
outerRing.Parent = logoContainer

local outerRingStroke = Instance.new("UIStroke")
outerRingStroke.Thickness = 4
outerRingStroke.Color = Color3.fromRGB(100, 170, 255)
outerRingStroke.Transparency = 0.2
outerRingStroke.Parent = outerRing

local outerGradient = Instance.new("UIGradient")
outerGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255)),
})
outerGradient.Parent = outerRingStroke

local innerRing = Instance.new("Frame")
innerRing.Size = UDim2.new(0.7, 0, 0.7, 0)
innerRing.AnchorPoint = Vector2.new(0.5, 0.5)
innerRing.Position = UDim2.new(0.5, 0, 0.5, 0)
innerRing.BackgroundTransparency = 1
innerRing.ZIndex = 3
innerRing.Parent = logoContainer

local innerStroke = Instance.new("UIStroke")
innerStroke.Thickness = 3
innerStroke.Color = Color3.fromRGB(255, 255, 255)
innerStroke.Transparency = 0.65
innerStroke.Parent = innerRing

local core = Instance.new("Frame")
core.Size = UDim2.new(0.32, 0, 0.32, 0)
core.AnchorPoint = Vector2.new(0.5, 0.5)
core.Position = UDim2.new(0.5, 0, 0.5, 0)
core.BackgroundColor3 = Color3.fromRGB(140, 190, 255)
core.ZIndex = 4
core.Parent = logoContainer

local coreCorner = Instance.new("UICorner")
coreCorner.CornerRadius = UDim.new(1, 0)
coreCorner.Parent = core

local creditImage = Instance.new("ImageLabel")
creditImage.Name = "CreditImage"
creditImage.Size = UDim2.new(0.78, 0, 0.78, 0)
creditImage.AnchorPoint = Vector2.new(0.5, 0.5)
creditImage.Position = UDim2.new(0.5, 0, 0.5, 0)
creditImage.BackgroundTransparency = 1
creditImage.Image = "rbxassetid://116124785628827"
creditImage.ScaleType = Enum.ScaleType.Crop
creditImage.ZIndex = 5
creditImage.Parent = logoContainer

task.spawn(function()
	while core.Parent do
		local grow = TweenService:Create(core, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0.4, 0, 0.4, 0),
			BackgroundColor3 = Color3.fromRGB(200, 220, 255),
		})
		grow:Play()
		grow.Completed:Wait()
		if not core.Parent then break end
		local shrink = TweenService:Create(core, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0.32, 0, 0.32, 0),
			BackgroundColor3 = Color3.fromRGB(140, 190, 255),
		})
		shrink:Play()
		shrink.Completed:Wait()
	end
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.AnchorPoint = Vector2.new(0.5, 0)
titleLabel.Position = UDim2.new(0.5, 0, 0.56, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "LOADING"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 36
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextTransparency = 0
titleLabel.ZIndex = 3
titleLabel.Parent = bg

local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 1.5
titleStroke.Color = Color3.fromRGB(100, 150, 255)
titleStroke.Transparency = 0.5
titleStroke.Parent = titleLabel

local barOuter = Instance.new("Frame")
barOuter.Size = UDim2.new(0, 420, 0, 10)
barOuter.AnchorPoint = Vector2.new(0.5, 0)
barOuter.Position = UDim2.new(0.5, 0, 0.7, 0)
barOuter.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
barOuter.BorderSizePixel = 0
barOuter.ZIndex = 3
barOuter.Parent = bg

local barOuterCorner = Instance.new("UICorner")
barOuterCorner.CornerRadius = UDim.new(1, 0)
barOuterCorner.Parent = barOuter

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(120, 170, 255)
barFill.BorderSizePixel = 0
barFill.ZIndex = 4
barFill.Parent = barOuter

local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(1, 0)
barFillCorner.Parent = barFill

local barFillGradient = Instance.new("UIGradient")
barFillGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 140, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 110, 255)),
})
barFillGradient.Parent = barFill

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(0, 420, 0, 24)
percentLabel.AnchorPoint = Vector2.new(0.5, 0)
percentLabel.Position = UDim2.new(0.5, 0, 0.725, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(200, 210, 240)
percentLabel.TextSize = 15
percentLabel.Font = Enum.Font.GothamMedium
percentLabel.ZIndex = 3
percentLabel.Parent = bg

-- ============================================
-- شبیه‌سازی پیشرفت لودینگ
-- ============================================
bg.BackgroundTransparency = 1
for _, obj in ipairs(bg:GetDescendants()) do
	if obj:IsA("TextLabel") then
		obj.TextTransparency = 1
	end
end
TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
task.wait(0.1)
TweenService:Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()
TweenService:Create(percentLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()

local totalDuration = 4.5
local steps = 100
local stepTime = totalDuration / steps

for i = 0, steps do
	local progress = i / steps
	barFill.Size = UDim2.new(progress, 0, 1, 0)
	percentLabel.Text = math.floor(progress * 100) .. "%"
	task.wait(stepTime)
end

titleLabel.Text = "READY"
task.wait(0.6)
task.cancel(particleSpawner)

local uiFadeTime = 0.6
TweenService:Create(titleLabel, TweenInfo.new(uiFadeTime, Enum.EasingStyle.Sine), {TextTransparency = 1}):Play()
TweenService:Create(titleStroke, TweenInfo.new(uiFadeTime, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
TweenService:Create(percentLabel, TweenInfo.new(uiFadeTime, Enum.EasingStyle.Sine), {TextTransparency = 1}):Play()
TweenService:Create(barOuter, TweenInfo.new(uiFadeTime, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
TweenService:Create(barFill, TweenInfo.new(uiFadeTime, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()

task.wait(uiFadeTime + 0.1)
titleLabel:Destroy()
percentLabel:Destroy()
barOuter:Destroy()

TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()

local moveTime = 1.1
local targetPos = UDim2.new(0, 90, 0, 90)
logoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
local moveTween = TweenService:Create(
	logoContainer,
	TweenInfo.new(moveTime, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),
	{Position = targetPos, Size = UDim2.new(0, 80, 0, 80)}
)
moveTween:Play()
moveTween.Completed:Wait()
-- ============================================
-- منوی اصلی F3x admin
-- ============================================
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "F3xAdminGUI"
mainGui.ResetOnSpawn = false
mainGui.DisplayOrder = 10
mainGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Size = UDim2.new(0, 280, 0, 460)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = mainGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.5
mainStroke.Color = Color3.fromRGB(90, 130, 220)
mainStroke.Transparency = 0.4
mainStroke.Parent = mainFrame

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 26, 36)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 22)),
})
mainGradient.Rotation = 90
mainGradient.Parent = mainFrame

-- هدر
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = header

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 16)
headerFix.Position = UDim2.new(0, 0, 1, -16)
headerFix.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
headerFix.BorderSizePixel = 0
headerFix.ZIndex = header.ZIndex
headerFix.Parent = header

local titleLabel2 = Instance.new("TextLabel")
titleLabel2.Size = UDim2.new(1, -20, 1, 0)
titleLabel2.Position = UDim2.new(0, 16, 0, 0)
titleLabel2.BackgroundTransparency = 1
titleLabel2.Text = "F3x admin"
titleLabel2.TextColor3 = Color3.fromRGB(230, 235, 255)
titleLabel2.TextSize = 18
titleLabel2.Font = Enum.Font.GothamBold
titleLabel2.TextXAlignment = Enum.TextXAlignment.Left
titleLabel2.TextTruncate = Enum.TextTruncate.AtEnd
titleLabel2.Parent = header

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.Position = UDim2.new(0, 0, 1, 0)
headerLine.BackgroundColor3 = Color3.fromRGB(70, 90, 140)
headerLine.BackgroundTransparency = 0.5
headerLine.BorderSizePixel = 0
headerLine.Parent = header

-- اسکرول فریم
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "NumberScroll"
scrollFrame.Size = UDim2.new(1, -20, 1, -60)
scrollFrame.Position = UDim2.new(0, 10, 0, 52)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(110, 150, 240)
scrollFrame.ScrollBarImageTransparency = 0.2
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollFrame.ElasticBehavior = Enum.ElasticBehavior.Always
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = scrollFrame

local listPadding = Instance.new("UIPadding")
listPadding.PaddingTop = UDim.new(0, 4)
listPadding.PaddingBottom = UDim.new(0, 4)
listPadding.PaddingLeft = UDim.new(0, 2)
listPadding.PaddingRight = UDim.new(0, 2)
listPadding.Parent = scrollFrame

-- ============================================
-- دکمه‌ها
-- ============================================
local rowColorA = Color3.fromRGB(32, 32, 44)
local rowColorB = Color3.fromRGB(26, 26, 36)

local buttons = {
	{name = "f3x", cmd = ";btools"},
	{name = "r6", cmd = ";r6"},
	{name = "shutdown", cmd = ";shutdown"},
	{name = "decal", cmd = "decal_script"},
	{name = "skybox", cmd = "skybox_script"},
	{name = "fire", cmd = ";fire all"},
	{name = "cmdbar 2", cmd = ";cmdbar2"},
	{name = "music 1", cmd = "music_script"},
	{name = "Partical", cmd = "particle_script"},
}

local function createButton(data, index)
	local btn = Instance.new("TextButton")
	btn.Name = "Btn_" .. data.name
	btn.Size = UDim2.new(1, 0, 0, 42)
	btn.BackgroundColor3 = (index % 2 == 0) and rowColorA or rowColorB
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.LayoutOrder = index
	btn.Text = data.name
	btn.TextColor3 = Color3.fromRGB(210, 215, 235)
	btn.TextSize = 15
	btn.Font = Enum.Font.GothamBold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Parent = scrollFrame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn

	local btnStroke = Instance.new("UIStroke")
	btnStroke.Thickness = 1
	btnStroke.Color = Color3.fromRGB(80, 110, 190)
	btnStroke.Transparency = 0.75
	btnStroke.Parent = btn

	local btnPadding = Instance.new("UIPadding")
	btnPadding.PaddingLeft = UDim.new(0, 14)
	btnPadding.Parent = btn

	local originalColor = btn.BackgroundColor3

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
			BackgroundColor3 = Color3.fromRGB(45, 55, 85),
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
			BackgroundColor3 = originalColor,
		}):Play()
	end)

	btn.MouseButton1Down:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
			BackgroundColor3 = Color3.fromRGB(90, 130, 230),
		}):Play()
	end)

	btn.MouseButton1Up:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
			BackgroundColor3 = originalColor,
		}):Play()
	end)

	if data.cmd == "decal_script" then
		btn.MouseButton1Click:Connect(function()
			local player = game.Players.LocalPlayer
			local char = player.Character
			local tool
			for i,v in player:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
			for i,v in game.ReplicatedStorage:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
			if not tool then return end
			local remote = tool.SyncAPI.ServerEndpoint
			local function _(args) remote:InvokeServer(unpack(args)) end
			function SetLocked(part,boolean)
				local args = {[1] = "SetLocked", [2] = {[1] = part}, [3] = boolean}
				_(args)
			end
			function SpawnDecal(part,side)
				local args = {[1] = "CreateTextures", [2] = {[1] = {["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal"}}}
				_(args)
			end
			function AddDecal(part,asset,side)
				local args = {[1] = "SyncTexture", [2] = {[1] = {["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://".. asset}}}
				_(args)
			end
			local id = "102182508491838"
			for i,v in game.workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v,false)
						SpawnDecal(v,Enum.NormalId.Front) AddDecal(v,id,Enum.NormalId.Front)
						SpawnDecal(v,Enum.NormalId.Back) AddDecal(v,id,Enum.NormalId.Back)
						SpawnDecal(v,Enum.NormalId.Right) AddDecal(v,id,Enum.NormalId.Right)
						SpawnDecal(v,Enum.NormalId.Left) AddDecal(v,id,Enum.NormalId.Left)
						SpawnDecal(v,Enum.NormalId.Bottom) AddDecal(v,id,Enum.NormalId.Bottom)
						SpawnDecal(v,Enum.NormalId.Top) AddDecal(v,id,Enum.NormalId.Top)
					end)
				end
			end
		end)

	elseif data.cmd == "skybox_script" then
		btn.MouseButton1Click:Connect(function()
			local player = game.Players.LocalPlayer
			local char = player.Character
			local tool
			for i,v in player:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
			for i,v in game.ReplicatedStorage:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
			if not tool then return end
			local remote = tool.SyncAPI.ServerEndpoint
			local function _(args) remote:InvokeServer(unpack(args)) end
			function CreatePart(cf,parent) local args = {[1] = "CreatePart", [2] = "Normal", [3] = cf, [4] = parent} _(args) end
			function SetName(part,stringg) local args = {[1] = "SetName", [2] = {[1] = part}, [3] = stringg} _(args) end
			function AddMesh(part) local args = {[1] = "CreateMeshes", [2] = {[1] = {["Part"] = part}}} _(args) end
			function SetMesh(part,meshid) local args = {[1] = "SyncMesh", [2] = {[1] = {["Part"] = part, ["MeshId"] = "rbxassetid://"..meshid}}} _(args) end
			function SetTexture(part,texid) local args = {[1] = "SyncMesh", [2] = {[1] = {["Part"] = part, ["TextureId"] = "rbxassetid://"..texid}}} _(args) end
			function MeshResize(part,size) local args = {[1] = "SyncMesh", [2] = {[1] = {["Part"] = part, ["Scale"] = size}}} _(args) end
			function SetLocked(part,boolean) local args = {[1] = "SetLocked", [2] = {[1] = part}, [3] = boolean} _(args) end
			function SetAnchor(boolean,part) local args = {[1] = "SyncAnchor", [2] = {[1] = {["Part"] = part, ["Anchored"] = boolean}}} _(args) end
			local root = char:WaitForChild("HumanoidRootPart")
			local pos = root.CFrame + Vector3.new(0, 6, 0)
			CreatePart(pos, workspace)
			task.wait(0.2)
			local skyPart
			for _, v in workspace:GetChildren() do
				if v:IsA("BasePart") and (v.Position - pos.Position).magnitude < 1 then
					skyPart = v
					break
				end
			end
			if skyPart then
				SetName(skyPart, "Sky")
				AddMesh(skyPart)
				SetMesh(skyPart, "111891702759441")
				SetTexture(skyPart, "136122989901562")
				MeshResize(skyPart, Vector3.new(1000, 1000, 1000))
				SetLocked(skyPart, true)
				SetAnchor(true, skyPart)
			end
		end)

	elseif data.cmd == "music_script" then
		btn.MouseButton1Click:Connect(function()
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
			RequestCommand:InvokeServer(";music 125995364970231")
			RequestCommand:InvokeServer(";pitch 0.1")
			RequestCommand:InvokeServer(";volume inf")
		end)

	elseif data.cmd == "particle_script" then
		btn.MouseButton1Click:Connect(function()
			local MyTargetID = "136122989901562"
			local player = game.Players.LocalPlayer
			local tool
			for i, v in player:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
			for i, v in game.ReplicatedStorage:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
			if not tool or not tool:FindFirstChild("SyncAPI") then
				warn("ابزار F3X پیدا نشد!")
				return
			end
			local remote = tool.SyncAPI.ServerEndpoint
			function Invoke(args) remote:InvokeServer(unpack(args)) end
			function FastInvoke(args) task.spawn(function() remote:InvokeServer(unpack(args)) end) end
			function SetCollision(part, boolean) FastInvoke({"SyncCollision", {{["Part"] = part, ["CanCollide"] = boolean}}}) end
			function SetAnchor(boolean, part) FastInvoke({"SyncAnchor", {{["Part"] = part, ["Anchored"] = boolean}}}) end
			function CreatePart(cf, parent) Invoke({"CreatePart", "Normal", cf, parent}) end
			function Resize(part, size, cf) FastInvoke({"SyncResize", {{["Part"] = part, ["CFrame"] = cf, ["Size"] = size}}}) end
			local function delete(part) FastInvoke({"Remove", {part}}) end
			function SetTrans(part, int) FastInvoke({"SyncMaterial", {{["Part"] = part, ["Transparency"] = int}}}) end
			function SpawnDecal(part, side) FastInvoke({"CreateTextures", {{["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal"}}}) end
			function AddDecal(part, asset, side) FastInvoke({"SyncTexture", {{["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://".. asset}}}) end
			function SetName(part, stringg) FastInvoke({"SetName", {part}, stringg}) end
			local function particle()
				while true do
					task.wait(0.3)
					for _, plr in pairs(game.Players:GetPlayers()) do
						if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
							local head = plr.Character.Head
							local targetX = head.Position.X + (math.random(-8, 8) / 10)
							local targetY = head.Position.Y + 0.2
							local targetZ = head.Position.Z + (math.random(-8, 8) / 10)
							local tempY = targetY + 1000
							local tempSpawnCF = CFrame.new(targetX, tempY, targetZ)
							task.spawn(function()
								CreatePart(tempSpawnCF, workspace)
								task.wait()
								for _, v in workspace:GetChildren() do
									if v:IsA("Part") and (v.Position - Vector3.new(targetX, tempY, targetZ)).Magnitude < 4 and v.Name ~= "MagicParticle" then
										local part = v
										SetName(part, "MagicParticle")
										SetCollision(part, false)
										SetAnchor(true, part)
										SetTrans(part, 1)
										SpawnDecal(part, Enum.NormalId.Front)
										AddDecal(part, MyTargetID, Enum.NormalId.Front)
										SpawnDecal(part, Enum.NormalId.Back)
										AddDecal(part, MyTargetID, Enum.NormalId.Back)
										local currentCF = CFrame.new(targetX, targetY, targetZ) * CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
										local currentSize = Vector3.new(2, 2, 0.001)
										Resize(part, currentSize, currentCF)
										task.delay(3, function() if part and part.Parent then delete(part) end end)
										local driftX = math.random(-2, 2) / 15
										local driftZ = math.random(-2, 2) / 15
										local speedY = 0.25
										local moveVector = Vector3.new(driftX, speedY, driftZ)
										local startTick = tick()
										while tick() - startTick < 2.9 do
											if part and part.Parent then
												currentCF = currentCF + moveVector
												Resize(part, currentSize, currentCF)
												task.wait(0.06)
											else
												break
											end
										end
										break
									end
								end
							end)
						end
					end
				end
			end
			coroutine.wrap(particle)()
		end)

	else
		btn.MouseButton1Click:Connect(function()
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
			RequestCommand:InvokeServer(data.cmd)
		end)
	end
end

for i, data in ipairs(buttons) do
	createButton(data, i)
end

-- ============================================
-- منطق درگ کردن پنجره
-- ============================================
local dragging = false
local dragStart
local startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(
		startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y
	)
end

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateDrag(input)
	end
end)

-- ============================================
-- فید-این ورودی منوی اصلی
-- ============================================
mainFrame.Size = UDim2.new(0, 280, 0, 0)
mainFrame.BackgroundTransparency = 1
header.BackgroundTransparency = 1
titleLabel2.TextTransparency = 1

TweenService:Create(mainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 280, 0, 460),
	BackgroundTransparency = 0,
}):Play()

TweenService:Create(header, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
task.wait(0.2)
TweenService:Create(titleLabel2, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {TextTransparency = 0}):Play()

task.wait(0.5)
loadingGui:Destroy()

print("F3x admin gui loaded successfully!")
