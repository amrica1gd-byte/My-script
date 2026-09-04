-- ============================================
-- United States of Sskid GUI (کوچک‌شده)
-- ============================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ============================================
-- لودینگ
-- ============================================

local function createLoadingScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EpicLoadingScreen"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Name = "Background"
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
    bg.BorderSizePixel = 0
    bg.Parent = screenGui

    local bgGradient = Instance.new("UIGradient")
    bgGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 14, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 14)),
    })
    bgGradient.Rotation = 90
    bgGradient.Parent = bg

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

    local outerRingStroke = Instance.new("UICorner")
    outerRingStroke.CornerRadius = UDim.new(1, 0)
    outerRingStroke.Parent = outerRing

    local outerRingUIStroke = Instance.new("UIStroke")
    outerRingUIStroke.Thickness = 4
    outerRingUIStroke.Color = Color3.fromRGB(100, 170, 255)
    outerRingUIStroke.Transparency = 0.2
    outerRingUIStroke.Parent = outerRing

    local outerGradient = Instance.new("UIGradient")
    outerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255)),
    })
    outerGradient.Parent = outerRingUIStroke

    local innerRing = Instance.new("Frame")
    innerRing.Size = UDim2.new(0.7, 0, 0.7, 0)
    innerRing.AnchorPoint = Vector2.new(0.5, 0.5)
    innerRing.Position = UDim2.new(0.5, 0, 0.5, 0)
    innerRing.BackgroundTransparency = 1
    innerRing.ZIndex = 3
    innerRing.Parent = logoContainer

    local innerCorner = Instance.new("UICorner")
    innerCorner.CornerRadius = UDim.new(1, 0)
    innerCorner.Parent = innerRing

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

    local creditImageCorner = Instance.new("UICorner")
    creditImageCorner.CornerRadius = UDim.new(1, 0)
    creditImageCorner.Parent = creditImage

    task.spawn(function()
        while core.Parent do
            local growTween = TweenService:Create(core, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0.4, 0, 0.4, 0),
                BackgroundColor3 = Color3.fromRGB(200, 220, 255),
            })
            growTween:Play()
            growTween.Completed:Wait()
            if not core.Parent then break end
            local shrinkTween = TweenService:Create(core, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0.32, 0, 0.32, 0),
                BackgroundColor3 = Color3.fromRGB(140, 190, 255),
            })
            shrinkTween:Play()
            shrinkTween.Completed:Wait()
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

    task.spawn(function()
        while titleLabel.Parent do
            local t1 = TweenService:Create(titleStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.1})
            t1:Play()
            t1.Completed:Wait()
            if not titleLabel.Parent then break end
            local t2 = TweenService:Create(titleStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6})
            t2:Play()
            t2.Completed:Wait()
        end
    end)

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

    local barOuterStroke = Instance.new("UIStroke")
    barOuterStroke.Thickness = 1
    barOuterStroke.Color = Color3.fromRGB(70, 70, 100)
    barOuterStroke.Transparency = 0.3
    barOuterStroke.Parent = barOuter

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
    TweenService:Create(barOuterStroke, TweenInfo.new(uiFadeTime, Enum.EasingStyle.Sine), {Transparency = 1}):Play()
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

    task.wait(0.5)
    screenGui:Destroy()
end

-- ============================================
-- پنل اصلی (کوچک‌شده)
-- ============================================

local function createMainGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "UnitedStatesOfSskid"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local bgDecalId = "87807438794592"

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 280, 0, 320)
    main.Position = UDim2.new(0.5, -140, 0.3, 0)
    main.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = main

    local bgImage = Instance.new("ImageLabel")
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.BackgroundTransparency = 1
    bgImage.Image = "rbxassetid://" .. bgDecalId
    bgImage.ScaleType = Enum.ScaleType.Crop
    bgImage.Parent = main

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    overlay.Parent = main

    local cornerDecal = Instance.new("ImageLabel")
    cornerDecal.Size = UDim2.new(0, 40, 0, 40)
    cornerDecal.Position = UDim2.new(1, -48, 0, 6)
    cornerDecal.BackgroundTransparency = 1
    cornerDecal.Image = "rbxassetid://" .. bgDecalId
    cornerDecal.Parent = main

    local cornerCorner = Instance.new("UICorner")
    cornerCorner.CornerRadius = UDim.new(1, 0)
    cornerCorner.Parent = cornerDecal

    RunService.Heartbeat:Connect(function()
        cornerDecal.Rotation = (cornerDecal.Rotation + 1) % 360
    end)

    -- عنوان جدید: Sskid gui
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 3)
    title.BackgroundTransparency = 1
    title.Text = "Sskid gui"
    title.TextColor3 = Color3.fromRGB(255, 40, 80)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = main

    function CreateBtn(parent, text, y, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.88, 0, 0, 30)
        btn.Position = UDim2.new(0.06, 0, 0, y)
        btn.Text = text
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 80)
        btn.BorderSizePixel = 0
        btn.Parent = parent
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 6)
        c.Parent = btn
        return btn
    end

    CreateBtn(main, "Sskid F3X", 45, Color3.fromRGB(160, 0, 50)).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/31364d41deb2e97c6d24fe0cbd6423d0/raw/dc0c56e8b0e1c0a83f5f4341625f10d147f2bae4/Sskid%2520f3x.Lua"))()
    end)

    CreateBtn(main, "Backdoor F3X", 85, Color3.fromRGB(0, 80, 160)).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/zibranIndonesia/36cd617e0f320cc86f070a9c6dc77036/raw/e81836fb347cc73be6cde23e60396d6f25850cf2/zibranF3X%2520Gui"))()
    end)

    CreateBtn(main, "Sskid back door", 125, Color3.fromRGB(50, 160, 50)).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sepehrali1/Sskid/refs/heads/main/Sskidbackdoor"))()
    end)

    CreateBtn(main, "Artin GUI", 165, Color3.fromRGB(150, 100, 0)).MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/amrica1gd-byte/99461d23ddd32a264ad822e70de00ce5/raw/3579fa1b9a0b67251eaae5ef582defdf2f77262c/Artin.gui.Lua"))()
    end)

    CreateBtn(main, "Nuke All", 205, Color3.fromRGB(200, 50, 0)).MouseButton1Click:Connect(function()
        local tool
        for _, v in pairs(player:GetDescendants()) do
            if v.Name == "SyncAPI" then
                tool = v.Parent
                break
            end
        end
        if not tool then
            for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
                if v.Name == "SyncAPI" then
                    tool = v.Parent
                    break
                end
            end
        end
        if not tool then return end
        local remote = tool.SyncAPI.ServerEndpoint
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                pcall(function()
                    remote:InvokeServer("Remove", {v})
                end)
            end
        end
    end)

    -- درگ
    local drag = false
    local ds, sp

    main.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            ds = Vector2.new(i.Position.X, i.Position.Y)
            sp = main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = Vector2.new(i.Position.X, i.Position.Y) - ds
            main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)

    print("Sskid gui Loaded")
end

createLoadingScreen()
task.wait(0.5)
createMainGUI()
