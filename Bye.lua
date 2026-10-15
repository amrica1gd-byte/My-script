local function protect()
	pcall(function()
		if getscriptbytecode then
			getscriptbytecode = function(...) while true do end end
		end
		if decompile then
			decompile = function(...) while true do end end
		end
	end)
end
protect()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LP = Players.LocalPlayer

pcall(function()
	local c = game:GetService("CoreGui"):FindFirstChild("SskidGuiReborn")
	if c then c:Destroy() end
end)

local SafeParent = game:GetService("CoreGui")
if gethui then
	local ok, res = pcall(gethui)
	if ok and res then SafeParent = res end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SskidGuiReborn"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = SafeParent

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local panelW, panelH
if isMobile then
	panelW = math.min(workspace.CurrentCamera.ViewportSize.X * 0.92, 400)
	panelH = math.min(workspace.CurrentCamera.ViewportSize.Y * 0.75, 500)
else
	panelW = math.min(workspace.CurrentCamera.ViewportSize.X * 0.4, 420)
	panelH = math.min(workspace.CurrentCamera.ViewportSize.Y * 0.7, 400)
end

local COLORS = {
	main = Color3.fromRGB(20, 10, 20),
	header = Color3.fromRGB(180, 20, 80),
	accent = Color3.fromRGB(255, 80, 150),
	darker = Color3.fromRGB(15, 5, 15),
	button = Color3.fromRGB(50, 20, 40),
	buttonHover = Color3.fromRGB(80, 30, 60),
	text = Color3.fromRGB(255, 220, 240),
	textDim = Color3.fromRGB(180, 140, 160),
}

local SKIN_DECAL = "rbxassetid://74603125473840"
local CORNER_DECAL = "rbxassetid://107364040359004"

local function corner(inst, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 12)
	c.Parent = inst
	return c
end

local function stroke(inst, color, t, tr)
	local s = Instance.new("UIStroke")
	s.Color = color or COLORS.accent
	s.Thickness = t or 1
	s.Transparency = tr or 0.5
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = inst
	return s
end

local function tween(inst, info, props)
	local t = TweenService:Create(inst, info, props)
	t:Play()
	return t
end

local function notify(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 3
		})
	end)
end

local CornerDecal = Instance.new("ImageLabel")
CornerDecal.Size = UDim2.new(0, 80, 0, 80)
CornerDecal.Position = UDim2.new(0, 20, 1, -100)
CornerDecal.BackgroundTransparency = 1
CornerDecal.Image = CORNER_DECAL
CornerDecal.ZIndex = 5
CornerDecal.Parent = ScreenGui
corner(CornerDecal, 40)
stroke(CornerDecal, COLORS.accent, 2, 0.4)

task.spawn(function()
	while CornerDecal and CornerDecal.Parent do
		CornerDecal.Rotation = (CornerDecal.Rotation + 1.5) % 360
		RunService.Heartbeat:Wait()
	end
end)

local BgSound = Instance.new("Sound")
BgSound.SoundId = "rbxassetid://1847661821"
BgSound.Volume = 0.5
BgSound.Looped = true
BgSound.Parent = SoundService

task.spawn(function()
	for i = 1, 10 do
		if BgSound.IsLoaded then break end
		BgSound.Loaded:Wait()
	end
	BgSound:Play()
end)
pcall(function() BgSound:Play() end)

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game:GetService("Lighting")

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.ZIndex = 100
LoadingFrame.Parent = ScreenGui

local LoadDecal = Instance.new("ImageLabel")
LoadDecal.Size = UDim2.new(0, 120, 0, 120)
LoadDecal.AnchorPoint = Vector2.new(0.5, 0.5)
LoadDecal.Position = UDim2.new(0.5, 0, 0.5, -60)
LoadDecal.BackgroundTransparency = 1
LoadDecal.Image = SKIN_DECAL
LoadDecal.ZIndex = 102
LoadDecal.Parent = LoadingFrame
corner(LoadDecal, 60)

task.spawn(function()
	while LoadDecal and LoadDecal.Parent do
		LoadDecal.Rotation = (LoadDecal.Rotation + 3) % 360
		RunService.Heartbeat:Wait()
	end
end)

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 40)
LoadTitle.AnchorPoint = Vector2.new(0.5, 0.5)
LoadTitle.Position = UDim2.new(0.5, 0, 0.5, 30)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "Sskid Gui Reborn"
LoadTitle.Font = Enum.Font.GothamBlack
LoadTitle.TextSize = 28
LoadTitle.TextColor3 = COLORS.accent
LoadTitle.ZIndex = 102
LoadTitle.Parent = LoadingFrame

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(1, 0, 0, 30)
LoadSub.AnchorPoint = Vector2.new(0.5, 0.5)
LoadSub.Position = UDim2.new(0.5, 0, 0.5, 65)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "Loading..."
LoadSub.Font = Enum.Font.Gotham
LoadSub.TextSize = 14
LoadSub.TextColor3 = COLORS.textDim
LoadSub.ZIndex = 102
LoadSub.Parent = LoadingFrame

local TapGui = Instance.new("ScreenGui")
TapGui.Name = "SskidTapGui"
TapGui.ResetOnSpawn = false
TapGui.IgnoreGuiInset = true
TapGui.DisplayOrder = 1000000
TapGui.Parent = SafeParent

local TapBtn = Instance.new("TextButton")
TapBtn.Size = UDim2.new(0, 150, 0, 45)
TapBtn.AnchorPoint = Vector2.new(0.5, 0.5)
TapBtn.Position = UDim2.new(0.5, 0, 0.5, 100)
TapBtn.BackgroundColor3 = COLORS.header
TapBtn.BorderSizePixel = 0
TapBtn.Text = "Tap here"
TapBtn.Font = Enum.Font.GothamBold
TapBtn.TextSize = 18
TapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TapBtn.AutoButtonColor = false
TapBtn.ZIndex = 999
TapBtn.Parent = TapGui
corner(TapBtn, 10)
stroke(TapBtn, COLORS.accent, 1, 0.4)

local loadSignal = Instance.new("BindableEvent")
local tapped = false

local function doLoad()
	if tapped then return end
	tapped = true
	loadSignal:Fire()
end

TapBtn.MouseButton1Click:Connect(doLoad)
task.spawn(function()
	task.wait(15)
	doLoad()
end)

tween(blur, TweenInfo.new(0.5), {Size = 10})

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, panelW, 0, panelH)
Main.BackgroundColor3 = COLORS.main
Main.BorderSizePixel = 0
Main.Visible = false
Main.ClipsDescendants = true
Main.ZIndex = 10
Main.Parent = ScreenGui
corner(Main, 14)
stroke(Main, COLORS.accent, 2, 0.3)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = COLORS.header
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 12
TopBar.Parent = Main
corner(TopBar, 14)

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 10)
TopFix.Position = UDim2.new(0, 0, 1, -10)
TopFix.BackgroundColor3 = COLORS.header
TopFix.BorderSizePixel = 0
TopFix.ZIndex = 12
TopFix.Parent = TopBar

local MiniLogo = Instance.new("ImageLabel")
MiniLogo.Size = UDim2.new(0, 28, 0, 28)
MiniLogo.Position = UDim2.new(0, 8, 0.5, -14)
MiniLogo.BackgroundTransparency = 1
MiniLogo.Image = SKIN_DECAL
MiniLogo.ZIndex = 13
MiniLogo.Parent = TopBar
corner(MiniLogo, 14)

task.spawn(function()
	while MiniLogo and MiniLogo.Parent do
		MiniLogo.Rotation = (MiniLogo.Rotation + 2) % 360
		RunService.Heartbeat:Wait()
	end
end)

local TopTitle = Instance.new("TextLabel")
TopTitle.BackgroundTransparency = 1
TopTitle.Size = UDim2.new(1, -140, 1, 0)
TopTitle.Position = UDim2.new(0, 44, 0, 0)
TopTitle.Text = "Sskid Gui Reborn"
TopTitle.Font = Enum.Font.GothamBlack
TopTitle.TextSize = 15
TopTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TopTitle.TextXAlignment = Enum.TextXAlignment.Left
TopTitle.ZIndex = 13
TopTitle.Parent = TopBar

local SoundBtn = Instance.new("TextButton")
SoundBtn.Size = UDim2.new(0, 26, 0, 26)
SoundBtn.Position = UDim2.new(1, -90, 0.5, -13)
SoundBtn.BackgroundColor3 = COLORS.darker
SoundBtn.BackgroundTransparency = 0.3
SoundBtn.BorderSizePixel = 0
SoundBtn.Text = "🔊"
SoundBtn.Font = Enum.Font.GothamBold
SoundBtn.TextSize = 13
SoundBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SoundBtn.AutoButtonColor = false
SoundBtn.ZIndex = 13
SoundBtn.Parent = TopBar
corner(SoundBtn, 6)

SoundBtn.MouseButton1Click:Connect(function()
	if BgSound.Playing then
		BgSound:Pause()
		SoundBtn.Text = "🔇"
	else
		BgSound:Resume()
		SoundBtn.Text = "🔊"
	end
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -60, 0.5, -13)
MinBtn.BackgroundColor3 = COLORS.darker
MinBtn.BackgroundTransparency = 0.3
MinBtn.BorderSizePixel = 0
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 13
MinBtn.Parent = TopBar
corner(MinBtn, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 10, 20)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 13
CloseBtn.Parent = TopBar
corner(CloseBtn, 6)

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	TapGui:Destroy()
	if BgSound then BgSound:Stop() end
	if blur then blur:Destroy() end
end)

local NavBar = Instance.new("Frame")
NavBar.Size = UDim2.new(1, -16, 0, 32)
NavBar.Position = UDim2.new(0, 8, 0, 46)
NavBar.BackgroundColor3 = COLORS.darker
NavBar.BorderSizePixel = 0
NavBar.ZIndex = 12
NavBar.Parent = Main
corner(NavBar, 8)
stroke(NavBar, COLORS.accent, 1, 0.6)

local NavIndicator = Instance.new("Frame")
NavIndicator.Size = UDim2.new(0.5, -2, 1, -4)
NavIndicator.Position = UDim2.new(0, 2, 0, 2)
NavIndicator.BackgroundColor3 = COLORS.header
NavIndicator.BackgroundTransparency = 0.1
NavIndicator.ZIndex = 12
NavIndicator.Parent = NavBar
corner(NavIndicator, 6)

local TabScripts = Instance.new("TextButton")
TabScripts.Size = UDim2.new(0.5, 0, 1, 0)
TabScripts.Position = UDim2.new(0, 0, 0, 0)
TabScripts.BackgroundTransparency = 1
TabScripts.Text = "📜 Scripts"
TabScripts.Font = Enum.Font.GothamBold
TabScripts.TextSize = 12
TabScripts.TextColor3 = Color3.fromRGB(255, 255, 255)
TabScripts.AutoButtonColor = false
TabScripts.ZIndex = 13
TabScripts.Parent = NavBar

local TabInfo = Instance.new("TextButton")
TabInfo.Size = UDim2.new(0.5, 0, 1, 0)
TabInfo.Position = UDim2.new(0.5, 0, 0, 0)
TabInfo.BackgroundTransparency = 1
TabInfo.Text = "ℹ️ Info"
TabInfo.Font = Enum.Font.GothamBold
TabInfo.TextSize = 12
TabInfo.TextColor3 = COLORS.textDim
TabInfo.AutoButtonColor = false
TabInfo.ZIndex = 13
TabInfo.Parent = NavBar

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -16, 1, -105)
PageContainer.Position = UDim2.new(0, 8, 0, 84)
PageContainer.BackgroundTransparency = 1
PageContainer.ClipsDescendants = true
PageContainer.ZIndex = 12
PageContainer.Parent = Main

local ScriptsPage = Instance.new("Frame")
ScriptsPage.Size = UDim2.new(1, 0, 1, 0)
ScriptsPage.BackgroundTransparency = 1
ScriptsPage.ZIndex = 12
ScriptsPage.Parent = PageContainer

local CategoryFrame = Instance.new("Frame")
CategoryFrame.Size = UDim2.new(1, 0, 0, 26)
CategoryFrame.Position = UDim2.new(0, 0, 0, 0)
CategoryFrame.BackgroundTransparency = 1
CategoryFrame.ZIndex = 12
CategoryFrame.Parent = ScriptsPage

local CatScroll = Instance.new("ScrollingFrame")
CatScroll.Size = UDim2.new(1, 0, 1, 0)
CatScroll.BackgroundTransparency = 1
CatScroll.BorderSizePixel = 0
CatScroll.ScrollBarThickness = 0
CatScroll.CanvasSize = UDim2.new(0,0,0,0)
CatScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
CatScroll.ScrollingDirection = Enum.ScrollingDirection.X
CatScroll.ZIndex = 12
CatScroll.Parent = CategoryFrame

local CatLayout = Instance.new("UIListLayout")
CatLayout.FillDirection = Enum.FillDirection.Horizontal
CatLayout.Padding = UDim.new(0, 5)
CatLayout.SortOrder = Enum.SortOrder.LayoutOrder
CatLayout.Parent = CatScroll

local Categories = {"All", "Admin", "Troll", "Backdoor", "Misc"}
local currentCategory = "All"
local categoryBtns = {}

for i, cat in ipairs(Categories) do
	local cbtn = Instance.new("TextButton")
	cbtn.Size = UDim2.new(0, 70, 1, 0)
	cbtn.BackgroundColor3 = COLORS.button
	cbtn.BackgroundTransparency = (cat == "All") and 0.2 or 0.5
	cbtn.BorderSizePixel = 0
	cbtn.Text = cat
	cbtn.TextColor3 = (cat == "All") and Color3.fromRGB(255,255,255) or COLORS.textDim
	cbtn.Font = Enum.Font.GothamBold
	cbtn.TextSize = 11
	cbtn.AutoButtonColor = false
	cbtn.ZIndex = 13
	cbtn.Parent = CatScroll
	corner(cbtn, 6)
	stroke(cbtn, COLORS.accent, 1, 0.6)
	categoryBtns[cat] = cbtn
end

local ScriptsScroll = Instance.new("ScrollingFrame")
ScriptsScroll.Size = UDim2.new(1, 0, 1, -32)
ScriptsScroll.Position = UDim2.new(0, 0, 0, 32)
ScriptsScroll.BackgroundColor3 = COLORS.darker
ScriptsScroll.BackgroundTransparency = 0.3
ScriptsScroll.BorderSizePixel = 0
ScriptsScroll.ScrollBarThickness = 4
ScriptsScroll.ScrollBarImageColor3 = COLORS.accent
ScriptsScroll.CanvasSize = UDim2.new(0,0,0,0)
ScriptsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptsScroll.ZIndex = 12
ScriptsScroll.Parent = ScriptsPage
corner(ScriptsScroll, 10)
stroke(ScriptsScroll, COLORS.accent, 1, 0.6)

local SList = Instance.new("UIListLayout")
SList.Padding = UDim.new(0, 4)
SList.SortOrder = Enum.SortOrder.LayoutOrder
SList.Parent = ScriptsScroll

local SPad = Instance.new("UIPadding")
SPad.PaddingTop = UDim.new(0, 6)
SPad.PaddingBottom = UDim.new(0, 6)
SPad.PaddingLeft = UDim.new(0, 6)
SPad.PaddingRight = UDim.new(0, 6)
SPad.Parent = ScriptsScroll

local Scripts = {
	{name = "Infinite Yield", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()', cat = "Admin"},
	{name = "Dark Dex", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/Dark%20Dex.lua"))()', cat = "Admin"},
	{name = "Owl Hub", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()', cat = "Admin"},
	{name = "Hack admin", code = 'loadstring(game:HttpGet("https://gist.githubusercontent.com/OfficialCynatica/636bed3e9ba0088733feb986768f8015/raw"))()', cat = "Admin"},
	{name = "F3X Backdoor", code = 'loadstring(game:HttpGet("https://gist.githubusercontent.com/zibranIndonesia/36cd617e0f320cc86f070a9c6dc77036/raw/e81836fb347cc73be6cde23e60396d6f25850cf2/zibranF3X%2520Gui"))()', cat = "Admin"},
	{name = "GtaV admin(pc)", code = 'loadstring(game:HttpGet("https://vt-now.github.io/VIOLENT/vt.lua"))()', cat = "Admin"},
	{name = "SskidF3X", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Sskidf3x/refs/heads/main/Ss"))()', cat = "Admin"},
	{name = "Cooking(F3X)", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Ss/refs/heads/main/ew"))()', cat = "Admin"},
	{name = "Hack Sound", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ac6-Music-Vulnerability-25536"))()', cat = "Troll"},
	{name = "Bang", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Pwnmaster99s-Universal-Stuffs-205984"))()', cat = "Troll"},
	{name = "Fling all", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/K1LAS1K/Ultimate-Fling-GUI/main/flingscript.lua"))()', cat = "Troll"},
	{name = "Wall hop", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Wall-hop-99778"))()', cat = "Troll"},
	{name = "Reanime", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/STEVE-916-create/Uhhhhhh/main/source/reanim.lua"))()', cat = "Troll"},
	{name = "Sword kill all", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GUI-Sword-Kill-all-V6-47125"))()', cat = "Troll"},
	{name = "Super ring", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Super-ring1/refs/heads/main/Super%20ring"))()', cat = "Troll"},
	{name = "Product Faker", code = 'loadstring(game:HttpGet("https://pastefy.app/yVlxzwk8/raw"))()', cat = "Troll"},
	{name = "Lalol hub", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-LALOL-Hub-Backdoor-Scanner-Without-the-Hint-52003"))()', cat = "Backdoor"},
	{name = "Sskid Backdoor", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Sskid/refs/heads/main/Sskidbackdoor"))()', cat = "Backdoor"},
	{name = "Vuln scan", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-TimurSide-backdoor-224728"))()', cat = "Backdoor"},
	{name = "Epic Backdoor", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Epic-Backdoor-SS-Executor-227858"))()', cat = "Backdoor"},
	{name = "Pipazz Backdoor", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fi-pipazz-new-106126"))()', cat = "Backdoor"},
	{name = "Hydroxide", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Upbolt/Hydroxide/master/init.lua"))()', cat = "Misc"},
	{name = "99 Night", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/99-Nights-in-the-Forest-Foxname-Hub-Made-By-EchoBuddyYTT-110418"))()', cat = "Misc"},
	{name = "Brookhaven", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/nxvap/Hexagon/refs/heads/main/brookhaven"))()', cat = "Misc"},
	{name = "UBG (vpn)", code = 'loadstring(game:HttpGet("https://eltonshub-loader.netlify.app/UBG1.lua"))()', cat = "Misc"},
	{name = "Scp 096", code = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-SCP-096-GUI-UNIVERSIAL-41936"))()', cat = "Misc"},
	{name = "Aimbot", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/lol-pixel-max/Lol-aimbot-esp-script/refs/heads/main/%60src/aimbot.lua%60"))()', cat = "Misc"},
	{name = "MoonSec Dumper", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/RayyyFirst/Main/refs/heads/main/Moonsec-V3Dumper"))()', cat = "Misc"},
	{name = "Server Hop", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Shadowsys/ServerHop/main/ServerHop.lua"))()', cat = "Misc"},
	{name = "Copy Game", code = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau"))()', cat = "Misc"},
}

local ScriptButtons = {}

local function refreshList()
	for _, b in ipairs(ScriptButtons) do b:Destroy() end
	ScriptButtons = {}

	for _, s in ipairs(Scripts) do
		local matchCat = (currentCategory == "All") or (s.cat == currentCategory)
		if matchCat then
			local b = Instance.new("TextButton")
			b.Size = UDim2.new(1, 0, 0, 30)
			b.BackgroundColor3 = COLORS.button
			b.BorderSizePixel = 0
			b.Text = "  " .. s.name .. "    [" .. s.cat .. "]"
			b.TextColor3 = COLORS.text
			b.Font = Enum.Font.GothamBold
			b.TextSize = 11
			b.TextXAlignment = Enum.TextXAlignment.Left
			b.AutoButtonColor = false
			b.ZIndex = 14
			b.Parent = ScriptsScroll
			corner(b, 8)
			stroke(b, COLORS.accent, 1, 0.7)

			b.MouseButton1Click:Connect(function()
				notify("Sskid", s.name .. " executing...")
				local ok, err = pcall(function()
					loadstring(s.code)()
				end)
				if not ok then
					notify("Error", tostring(err):sub(1, 50))
				else
					notify("Success", s.name .. " loaded!")
				end
			end)

			b.MouseEnter:Connect(function()
				tween(b, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.buttonHover})
			end)
			b.MouseLeave:Connect(function()
				tween(b, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.button})
			end)

			table.insert(ScriptButtons, b)
		end
	end
end

for cat, btn in pairs(categoryBtns) do
	btn.MouseButton1Click:Connect(function()
		currentCategory = cat
		for c, b in pairs(categoryBtns) do
			if c == cat then
				b.BackgroundTransparency = 0.2
				b.TextColor3 = Color3.fromRGB(255,255,255)
			else
				b.BackgroundTransparency = 0.5
				b.TextColor3 = COLORS.textDim
			end
		end
		refreshList()
	end)
end

refreshList()

local InfoPage = Instance.new("ScrollingFrame")
InfoPage.Size = UDim2.new(1, 0, 1, 0)
InfoPage.BackgroundColor3 = COLORS.darker
InfoPage.BackgroundTransparency = 0.3
InfoPage.BorderSizePixel = 0
InfoPage.ScrollBarThickness = 4
InfoPage.ScrollBarImageColor3 = COLORS.accent
InfoPage.CanvasSize = UDim2.new(0, 0, 0, 0)
InfoPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
InfoPage.Visible = false
InfoPage.ZIndex = 12
InfoPage.Parent = PageContainer
corner(InfoPage, 10)
stroke(InfoPage, COLORS.accent, 1, 0.6)

local IList = Instance.new("UIListLayout")
IList.Padding = UDim.new(0, 8)
IList.Parent = InfoPage

local IPad = Instance.new("UIPadding")
IPad.PaddingTop = UDim.new(0, 10)
IPad.PaddingBottom = UDim.new(0, 10)
IPad.PaddingLeft = UDim.new(0, 10)
IPad.PaddingRight = UDim.new(0, 10)
IPad.Parent = InfoPage

local SkinCard = Instance.new("Frame")
SkinCard.Size = UDim2.new(1, 0, 0, 140)
SkinCard.BackgroundColor3 = COLORS.button
SkinCard.BorderSizePixel = 0
SkinCard.LayoutOrder = 1
SkinCard.ZIndex = 12
SkinCard.Parent = InfoPage
corner(SkinCard, 12)
stroke(SkinCard, COLORS.accent, 1, 0.5)

local SkinImg = Instance.new("ImageLabel")
SkinImg.Size = UDim2.new(0, 100, 0, 100)
SkinImg.AnchorPoint = Vector2.new(0.5, 0.5)
SkinImg.Position = UDim2.new(0.5, 0, 0.45, 0)
SkinImg.BackgroundTransparency = 1
SkinImg.Image = SKIN_DECAL
SkinImg.ZIndex = 13
SkinImg.Parent = SkinCard
corner(SkinImg, 50)

task.spawn(function()
	while SkinImg and SkinImg.Parent do
		SkinImg.Rotation = (SkinImg.Rotation + 1.5) % 360
		RunService.Heartbeat:Wait()
	end
end)

local SkinLabel = Instance.new("TextLabel")
SkinLabel.Size = UDim2.new(1, 0, 0, 18)
SkinLabel.Position = UDim2.new(0, 0, 1, -22)
SkinLabel.BackgroundTransparency = 1
SkinLabel.Text = "Sskidvc"
SkinLabel.Font = Enum.Font.GothamBold
SkinLabel.TextSize = 13
SkinLabel.TextColor3 = COLORS.text
SkinLabel.ZIndex = 13
SkinLabel.Parent = SkinCard

local infoKeys = {
	{icon = "👤", key = "Roblox", value = "Sskidvc"},
	{icon = "📢", key = "Channel", value = "t.me/Sskidscript"},
	{icon = "👥", key = "Group", value = "t.me/SskidVanguard"},
	{icon = "💬", key = "Telegram", value = "@Sskidvc"},
	{icon = "🎵", key = "TikTok", value = "sskidvc"},
}

for i, item in ipairs(infoKeys) do
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundColor3 = COLORS.button
	row.BorderSizePixel = 0
	row.LayoutOrder = i + 1
	row.ZIndex = 12
	row.Parent = InfoPage
	corner(row, 10)
	stroke(row, COLORS.accent, 1, 0.6)

	local k = Instance.new("TextLabel")
	k.Size = UDim2.new(0.5, 0, 1, 0)
	k.Position = UDim2.new(0, 12, 0, 0)
	k.BackgroundTransparency = 1
	k.Text = item.icon .. " " .. item.key
	k.Font = Enum.Font.GothamBold
	k.TextSize = 12
	k.TextColor3 = COLORS.text
	k.TextXAlignment = Enum.TextXAlignment.Left
	k.ZIndex = 13
	k.Parent = row

	local v = Instance.new("TextLabel")
	v.Size = UDim2.new(0.5, -12, 1, 0)
	v.Position = UDim2.new(0.5, 0, 0, 0)
	v.BackgroundTransparency = 1
	v.Text = item.value
	v.Font = Enum.Font.Gotham
	v.TextSize = 11
	v.TextColor3 = COLORS.accent
	v.TextXAlignment = Enum.TextXAlignment.Right
	v.TextTruncate = Enum.TextTruncate.AtEnd
	v.ZIndex = 13
	v.Parent = row
end

local function selectTab(name)
	local pos
	if name == "scripts" then pos = UDim2.new(0, 2, 0, 2)
	else pos = UDim2.new(0.5, 0, 0, 2) end

	tween(NavIndicator, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = pos})

	TabScripts.TextColor3 = (name == "scripts") and Color3.fromRGB(255, 255, 255) or COLORS.textDim
	TabInfo.TextColor3 = (name == "info") and Color3.fromRGB(255, 255, 255) or COLORS.textDim

	ScriptsPage.Visible = (name == "scripts")
	InfoPage.Visible = (name == "info")
end

TabScripts.MouseButton1Click:Connect(function() selectTab("scripts") end)
TabInfo.MouseButton1Click:Connect(function() selectTab("info") end)

local minimized = false

MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		Main.Size = UDim2.new(0, panelW, 0, 40)
		tween(blur, TweenInfo.new(0.2), {Size = 0})
		NavBar.Visible = false
		PageContainer.Visible = false
		MinBtn.Text = "+"
	else
		Main.Size = UDim2.new(0, panelW, 0, panelH)
		tween(blur, TweenInfo.new(0.2), {Size = 10})
		NavBar.Visible = true
		PageContainer.Visible = true
		MinBtn.Text = "-"
	end
end)

local dragging, dragStart, startPos = false, nil, nil

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

task.spawn(function()
	loadSignal.Event:Wait()

	tween(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
	tween(LoadDecal, TweenInfo.new(0.5), {ImageTransparency = 1})
	tween(LoadTitle, TweenInfo.new(0.4), {TextTransparency = 1})
	tween(LoadSub, TweenInfo.new(0.4), {TextTransparency = 1})
	tween(TapBtn, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1})

	task.wait(0.6)
	LoadingFrame:Destroy()
	TapGui:Destroy()

	Main.Visible = true
	Main.Size = UDim2.new(0, panelW * 0.7, 0, panelH * 0.7)
	tween(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
		Size = UDim2.new(0, panelW, 0, panelH),
	})
end)

LP.CharacterAdded:Connect(function()
	task.wait(0.5)
	if ScreenGui and ScreenGui.Parent then
		ScreenGui.Enabled = true
	end
end)

print("[Sskid Gui Reborn] Loaded")
