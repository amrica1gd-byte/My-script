-- ============================================
--  Artin f3x gui - Panel با ۷ دکمه
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ArtinF3XGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ============================================
-- پنل اصلی
-- ============================================
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 340)
main.Position = UDim2.new(0.5, -125, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0, 200, 255)
stroke.Thickness = 1.5
stroke.Transparency = 0.3

-- ============================================
-- هدر (برای درگ)
-- ============================================
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 36)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -10, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔧 Artin f3x gui"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
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
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- ============================================
-- سیستم درگ
-- ============================================
local function makeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            dragStart = inp.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
makeDraggable(main, header)

-- ============================================
-- تابع ساخت دکمه
-- ============================================
local function createButton(text, yPos, color, link)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 13
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
-- دکمه‌ها
-- ============================================
createButton("📌 F3x admin", 0.12, Color3.fromRGB(40, 40, 60), 
    "https://gist.githubusercontent.com/amrica1gd-byte/86f9b1dae264b0531b7b7e90a20ad227/raw/4d2e4b724666929d0809d07d2aa9d7c0dd55f0de/Artin%2520f3x.Lua")

createButton("🔧 Give btools", 0.24, Color3.fromRGB(40, 40, 60), 
    "https://gist.githubusercontent.com/amrica1gd-byte/86f9b1dae264b0531b7b7e90a20ad227/raw/4d2e4b724666929d0809d07d2aa9d7c0dd55f0de/Artin%2520f3x.Lua")

createButton("🗺️ Map f3x gui", 0.36, Color3.fromRGB(40, 40, 60), 
    "https://api.rubis.app/v2/scrap/swW60uW8gffCYePI/raw")

createButton("🚪 Back door f3x", 0.48, Color3.fromRGB(40, 40, 60), 
    "https://gist.githubusercontent.com/zibranIndonesia/36cd617e0f320cc86f070a9c6dc77036/raw/e81836fb347cc73be6cde23e60396d6f25850cf2/zibranF3X%2520Gui")

createButton("💬 Spam gui", 0.60, Color3.fromRGB(40, 40, 60), 
    "https://gist.githubusercontent.com/amrica1gd-byte/e0d7c29a247ae105f8c5bf9301f3cc1d/raw/5109c2dc20a224da859216b8b64a59e65da1ea36/Spam%2520gui%2520duble.Lua")

createButton("🔨 F3X BAN HAMMER (R6)", 0.72, Color3.fromRGB(40, 40, 60), 
    "https://raw.githubusercontent.com/ermiya1231/Script1/refs/heads/main/newprojectbro")

createButton("🔥 Rc7_team f3x", 0.84, Color3.fromRGB(40, 40, 60), 
    "https://rawscripts.net/raw/Universal-Script-F3x-gui-rianz-rc7-216190")

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

print("✅ Artin f3x gui Loaded!")
