-- ============================================
-- Spider Man GUI - Classic Black & White + To next world
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

local gui = Instance.new("ScreenGui")
gui.Name = "SpiderManPanel"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ============================================
-- Classic Filter
-- ============================================

local classic = Instance.new("ColorCorrectionEffect")
classic.Name = "ClassicFilter"
classic.Saturation = -1
classic.Contrast = 0
classic.Brightness = 0
classic.Enabled = false
classic.Parent = Lighting

-- ============================================
-- پنل اصلی (با ارتفاع مناسب)
-- ============================================

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 220, 0, 240) -- افزایش ارتفاع برای فاصله‌ی بهتر
main.Position = UDim2.new(0.5, -110, 0.5, -120)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(200, 0, 0)
stroke.Thickness = 1.5
stroke.Transparency = 0.3

-- ============================================
-- هدر
-- ============================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 32)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
header.BorderSizePixel = 0
header.Parent = main

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🕷️ Spider Man GUI"
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ============================================
-- سیستم درگ
-- ============================================

local function makeDraggable(frame, handle)
    local dragging = false
    local dragStart
    local startPos

    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = inp.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (
            inp.UserInputType == Enum.UserInputType.MouseMovement
            or inp.UserInputType == Enum.UserInputType.Touch
        ) then

            local d = inp.Position - dragStart

            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + d.X,
                startPos.Y.Scale,
                startPos.Y.Offset + d.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then

            dragging = false
        end
    end)
end

makeDraggable(main, header)

-- ============================================
-- ساخت دکمه (برای لینک)
-- ============================================

local function createButton(text, yPos, color, link)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = main

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet(link))()
    end)

    return btn
end

-- ============================================
-- دکمه‌ها (با فاصله‌ی یکنواخت)
-- ============================================
-- فرمول: yPos = 0.08 + (index - 1) * 0.17
-- 4 دکمه: 0.08, 0.25, 0.42, 0.59

local webSpiderBtn = createButton(
    "🕸️ Web Spider",
    0.10,
    Color3.fromRGB(180, 30, 30),
    "https://rawscripts.net/raw/Universal-Script-Spider-man-script-i-made-with-grok-and-chatgpt-80621"
)

local proClickBtn = createButton(
    "⚡ Pro Click Panel",
    0.27,
    Color3.fromRGB(30, 80, 200),
    "https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/script33"
)

local nextWorldBtn = createButton(
    "🕷️ To next world",
    0.44,
    Color3.fromRGB(150, 0, 255),
    "" -- این دکمه لینک ندارد، مستقیم اجرا می‌شود
)

-- دکمه To next world (اجرای مستقیم)
nextWorldBtn.MouseButton1Click:Connect(function()
    local servers = {}
    local req = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
    local body = HttpService:JSONDecode(req)

    if body and body.data then
        for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end

    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], player)
        print("🕷️ To next world: Teleporting to a new server...")
    else
        print("🕷️ To next world: No other servers found.")
    end
end)

-- ============================================
-- Classic ON / OFF
-- ============================================

local classicBtn = Instance.new("TextButton")
classicBtn.Size = UDim2.new(0.9, 0, 0, 35)
classicBtn.Position = UDim2.new(0.05, 0, 0.61, 0)
classicBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
classicBtn.Text = "🖤 Classic: OFF"
classicBtn.TextColor3 = Color3.new(1, 1, 1)
classicBtn.TextSize = 14
classicBtn.Font = Enum.Font.GothamBold
classicBtn.BorderSizePixel = 0
classicBtn.Parent = main

Instance.new("UICorner", classicBtn).CornerRadius = UDim.new(0, 8)

classicBtn.MouseButton1Click:Connect(function()
    classic.Enabled = not classic.Enabled
    if classic.Enabled then
        classicBtn.Text = "🖤 Classic: ON"
        classicBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    else
        classicBtn.Text = "🖤 Classic: OFF"
        classicBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- ============================================
-- انیمیشن رنگ عنوان
-- ============================================

task.spawn(function()
    while gui.Parent do
        for h = 0, 1, 0.02 do
            title.TextColor3 = Color3.fromHSV(h, 0.8, 1)
            task.wait(0.05)
        end
    end
end)
