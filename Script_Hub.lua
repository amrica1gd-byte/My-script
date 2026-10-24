--========================================================
-- SCRIPT HUB | BY ARTIN
-- Home | Categories | Favorites | Animated Minimize
-- Mobile + Desktop | Safe UI Preview
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("ScriptHub")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(12, 14, 25),
    panel = Color3.fromRGB(20, 23, 39),
    card = Color3.fromRGB(29, 33, 53),
    purple = Color3.fromRGB(145, 85, 255),
    blue = Color3.fromRGB(40, 190, 255),
    white = Color3.fromRGB(245, 245, 255),
    muted = Color3.fromRGB(145, 153, 180),
    green = Color3.fromRGB(70, 230, 160),
    red = Color3.fromRGB(255, 90, 115),
    gold = Color3.fromRGB(255, 195, 70)
}

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
    return c
end

local function outline(obj, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = 1
    s.Transparency = transparency or 0
    s.Parent = obj
    return s
end

local function tw(obj, duration, props, style)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration, style or Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local gui = make("ScreenGui", {
    Name = "ScriptHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, playerGui)

local favorites = {}
local currentPage = "Home"
local searchToken = 0
local isLoading = false
local minimized = false
local cachedResults = {}
local currentQuery = ""

local main = make("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(320, 470),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)

corner(main, 16)
outline(main, C.purple, 0.25)

make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 21, 51)),
        ColorSequenceKeypoint.new(1, C.bg)
    }),
    Rotation = 35
}, main)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 62),
    BackgroundColor3 = Color3.fromRGB(30, 24, 57),
    BorderSizePixel = 0,
    ZIndex = 2
}, main)

make("UIGradient", {
    Color = ColorSequence.new(C.purple, C.blue),
    Rotation = 0
}, header)

local logo = make("TextLabel", {
    Position = UDim2.fromOffset(13, 7),
    Size = UDim2.new(1, -105, 0, 27),
    BackgroundTransparency = 1,
    Text = "✦ SCRIPT HUB",
    TextColor3 = C.white,
    TextSize = 18,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

make("TextLabel", {
    Position = UDim2.fromOffset(15, 34),
    Size = UDim2.new(1, -110, 0, 17),
    BackgroundTransparency = 1,
    Text = "NEON INTERFACE  •  ARTIN",
    TextColor3 = C.white,
    TextTransparency = 0.15,
    TextSize = 9,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local minBtn = make("TextButton", {
    Position = UDim2.new(1, -67, 0, 12),
    Size = UDim2.fromOffset(26, 26),
    BackgroundColor3 = C.card,
    Text = "—",
    TextColor3 = C.white,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, header)
corner(minBtn, 8)

local closeBtn = make("TextButton", {
    Position = UDim2.new(1, -35, 0, 12),
    Size = UDim2.fromOffset(26, 26),
    BackgroundColor3 = C.red,
    Text = "×",
    TextColor3 = C.white,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false
}, header)
corner(closeBtn, 8)

local restoreBtn = make("TextButton", {
    Name = "Restore",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -18, 1, -35),
    Size = UDim2.fromOffset(54, 54),
    BackgroundColor3 = C.purple,
    Text = "✦",
    TextColor3 = C.white,
    TextSize = 26,
    Font = Enum.Font.GothamBlack,
    Visible = false,
    AutoButtonColor = false
}, gui)
corner(restoreBtn, 18)
outline(restoreBtn, C.blue, 0.15)
make("UIGradient", {
    Color = ColorSequence.new(C.purple, C.blue),
    Rotation = 45
}, restoreBtn)

local status = make("TextLabel", {
    Position = UDim2.fromOffset(13, 65),
    Size = UDim2.new(1, -26, 0, 19),
    BackgroundTransparency = 1,
    Text = "● READY",
    TextColor3 = C.green,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, main)

local track = make("Frame", {
    Position = UDim2.fromOffset(13, 86),
    Size = UDim2.new(1, -26, 0, 3),
    BackgroundColor3 = C.card,
    BorderSizePixel = 0,
    Visible = false
}, main)
corner(track, 3)

local bar = make("Frame", {
    Size = UDim2.new(0.28, 0, 1, 0),
    BackgroundColor3 = C.blue,
    BorderSizePixel = 0
}, track)
corner(bar, 3)
make("UIGradient", {
    Color = ColorSequence.new(C.purple, C.blue)
}, bar)

local function startLoading()
    track.Visible = true
    task.spawn(function()
        while isLoading and gui.Parent do
            bar.Position = UDim2.new(-0.3, 0, 0, 0)
            local t = tw(bar, 0.8, {
                Position = UDim2.new(1, 0, 0, 0)
            }, Enum.EasingStyle.Linear)
            t.Completed:Wait()
        end
    end)
end

local function stopLoading()
    isLoading = false
    track.Visible = false
end

local content = make("Frame", {
    Position = UDim2.fromOffset(10, 96),
    Size = UDim2.new(1, -20, 1, -151),
    BackgroundTransparency = 1,
    ClipsDescendants = true
}, main)

local pageHolder = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, pageHolder)

local nav = make("Frame", {
    Position = UDim2.new(0, 10, 1, -48),
    Size = UDim2.new(1, -20, 0, 40),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, main)
corner(nav, 12)
outline(nav, C.purple, 0.7)

local function clearPage()
    for _, child in ipairs(pageHolder:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end
end

local function label(parent, text, size, color, font)
    return make("TextLabel", {
        Size = size,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or C.white,
        TextSize = 12,
        Font = font or Enum.Font.GothamMedium,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    }, parent)
end

local function button(parent, text, size, color)
    local b = make("TextButton", {
        Size = size,
        BackgroundColor3 = color or C.card,
        Text = text,
        TextColor3 = C.white,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, parent)
    corner(b, 9)
    b.MouseEnter:Connect(function()
        tw(b, 0.15, {BackgroundColor3 = C.blue})
    end)
    b.MouseLeave:Connect(function()
        tw(b, 0.15, {BackgroundColor3 = color or C.card})
    end)
    return b
end

local renderPage

local function createResultList(parent, results)
    local scroll = make("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.purple,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, parent)

    make("UIPadding", {
        PaddingTop = UDim.new(0, 3),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 2)
    }, scroll)

    make("UIListLayout", {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, scroll)

    if #results == 0 then
        local empty = label(scroll,
            currentPage == "Favorites"
                and "☆\nNo favorites yet.\nTap ☆ on any result to save it."
                or "⌕\nNo results yet.\nSearch for a script to get started.",
            UDim2.new(1, -8, 0, 100), C.muted)
        empty.TextXAlignment = Enum.TextXAlignment.Center
        return
    end

    for index, data in ipairs(results) do
        local slug = tostring(data.slug or data.title or index)
        local isFav = favorites[slug] ~= nil

        local card = make("Frame", {
            Size = UDim2.new(1, -4, 0, 91),
            BackgroundColor3 = C.card,
            BorderSizePixel = 0,
            LayoutOrder = index,
            BackgroundTransparency = 1
        }, scroll)
        corner(card, 11)
        local edge = outline(card, C.purple, 0.8)

        local gameName = "Universal"
        if type(data.game) == "table" then
            gameName = tostring(data.game.name or "Universal")
        end

        local title = label(card, tostring(data.title or "Untitled Script"),
            UDim2.new(1, -85, 0, 25), C.white, Enum.Font.GothamBold)
        title.Position = UDim2.fromOffset(9, 6)
        title.TextTruncate = Enum.TextTruncate.AtEnd

        local game = label(card, gameName,
            UDim2.new(1, -85, 0, 17), C.muted)
        game.Position = UDim2.fromOffset(9, 32)
        game.TextTruncate = Enum.TextTruncate.AtEnd

        local views = label(card, "◉ " .. tostring(data.views or 0) .. " views",
            UDim2.new(0.55, 0, 0, 17), C.green)
        views.Position = UDim2.fromOffset(9, 60)

        local favBtn = button(card, isFav and "★" or "☆",
            UDim2.fromOffset(30, 27), C.panel)
        favBtn.Position = UDim2.new(1, -38, 0, 7)
        favBtn.TextColor3 = C.gold
        favBtn.TextSize = 17

        favBtn.Activated:Connect(function()
            if favorites[slug] then
                favorites[slug] = nil
                favBtn.Text = "☆"
                status.Text = "☆ REMOVED FROM FAVORITES"
            else
                favorites[slug] = data
                favBtn.Text = "★"
                status.Text = "★ ADDED TO FAVORITES"
            end
            status.TextColor3 = C.gold
            if currentPage == "Favorites" then
                task.delay(0.1, function()
                    if currentPage == "Favorites" and gui.Parent then
                        renderPage("Favorites")
                    end
                end)
            end
        end)

        local exec = button(card, "▶ EXECUTE",
            UDim2.fromOffset(76, 29), C.purple)
        exec.Position = UDim2.new(1, -84, 0, 47)
        exec.TextSize = 9
        exec.Activated:Connect(function()
            tw(exec, 0.12, {Size = UDim2.fromOffset(80, 31)})
            exec.Text = "PREVIEW"
            status.Text = "● EXECUTION DISABLED"
            status.TextColor3 = C.blue
            task.delay(0.7, function()
                if exec.Parent then
                    tw(exec, 0.12, {Size = UDim2.fromOffset(76, 29)})
                    exec.Text = "▶ EXECUTE"
                end
            end)
        end)

        card.MouseEnter:Connect(function()
            tw(edge, 0.15, {Transparency = 0.15})
            tw(card, 0.15, {BackgroundTransparency = 0})
        end)
        card.MouseLeave:Connect(function()
            tw(edge, 0.15, {Transparency = 0.8})
            tw(card, 0.15, {BackgroundTransparency = 0.05})
        end)
        tw(card, 0.3, {BackgroundTransparency = 0.05})
        task.wait(0.015)
    end
end

local function searchScripts(query)
    searchToken += 1
    local token = searchToken
    currentQuery = query
    clearPage()
    isLoading = true
    status.Text = "● SEARCHING..."
    status.TextColor3 = C.blue
    startLoading()

    local resultArea = make("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }, pageHolder)

    task.spawn(function()
        local ok, response = pcall(function()
            return game:HttpGet(
                "https://scriptblox.com/api/script/search?q="
                .. HttpService:UrlEncode(query) .. "&max=20"
            )
        end)

        if token ~= searchToken or not gui.Parent then return end

        if not ok then
            stopLoading()
            status.Text = "✕ CONNECTION ERROR"
            status.TextColor3 = C.red
            label(resultArea, "Unable to fetch results.\nCheck HTTP support.",
                UDim2.new(1, 0, 0, 65), C.red)
            return
        end

        local decoded, data = pcall(function()
            return HttpService:JSONDecode(response)
        end)

        if not decoded or type(data) ~= "table"
            or type(data.result) ~= "table"
            or type(data.result.scripts) ~= "table" then
            stopLoading()
            status.Text = "✕ INVALID RESPONSE"
            status.TextColor3 = C.red
            return
        end

        cachedResults = data.result.scripts
        createResultList(resultArea, cachedResults)
        stopLoading()
        status.Text = "✓ " .. #cachedResults .. " RESULTS"
        status.TextColor3 = C.green
    end)
end

local function renderHome()
    clearPage()

    local welcome = make("Frame", {
        Size = UDim2.new(1, 0, 0, 88),
        BackgroundColor3 = C.panel,
        LayoutOrder = 1
    }, pageHolder)
    corner(welcome, 13)
    outline(welcome, C.purple, 0.5)

    local w1 = label(welcome, "✦ WELCOME TO SCRIPT HUB",
        UDim2.new(1, -20, 0, 27), C.white, Enum.Font.GothamBlack)
    w1.Position = UDim2.fromOffset(12, 10)

    local w2 = label(welcome, "Your script discovery hub",
        UDim2.new(1, -20, 0, 22), C.muted)
    w2.Position = UDim2.fromOffset(12, 43)

    local searchTitle = label(pageHolder, "⌕  QUICK SEARCH",
        UDim2.new(1, 0, 0, 22), C.blue, Enum.Font.GothamBold)
    searchTitle.LayoutOrder = 2

    local searchRow = make("Frame", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }, pageHolder)

    local box = make("TextBox", {
        Size = UDim2.new(1, -78, 1, 0),
        BackgroundColor3 = C.panel,
        TextColor3 = C.white,
        PlaceholderColor3 = C.muted,
        PlaceholderText = "Try: simulator, horror...",
        Text = currentQuery,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
        BorderSizePixel = 0
    }, searchRow)
    corner(box, 9)

    local go = button(searchRow, "SEARCH",
        UDim2.fromOffset(70, 38), C.purple)
    go.Position = UDim2.new(1, -70, 0, 0)

    local function run()
        local q = box.Text:match("^%s*(.-)%s*$")
        if q ~= "" then
            renderPage("Search")
            searchScripts(q)
        else
            status.Text = "! ENTER A SEARCH TERM"
            status.TextColor3 = C.red
        end
    end
    go.Activated:Connect(run)
    box.FocusLost:Connect(function(enter)
        if enter then run() end
    end)

    local catTitle = label(pageHolder, "▦  POPULAR CATEGORIES",
        UDim2.new(1, 0, 0, 22), C.blue, Enum.Font.GothamBold)
    catTitle.LayoutOrder = 4

    local categories = {
        {"🌐 Universal", "universal"},
        {"🏃 Simulator", "simulator"},
        {"👻 Horror", "horror"},
        {"⚔️ Fighting", "fighting"},
        {"🏡 Tycoon", "tycoon"},
        {"🧗 Obby", "obby"}
    }

    local grid = make("Frame", {
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundTransparency = 1,
        LayoutOrder = 5
    }, pageHolder)

    make("UIGridLayout", {
        CellSize = UDim2.new(0.5, -5, 0, 43),
        CellPadding = UDim2.fromOffset(7, 7),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, grid)

    for _, item in ipairs(categories) do
        local b = button(grid, item[1],
            UDim2.new(0.5, -5, 0, 43), C.card)
        b.TextSize = 10
        b.Activated:Connect(function()
            renderPage("Search")
            searchScripts(item[2])
        end)
    end

    local recentTitle = label(pageHolder, "◷  RECENT RESULTS",
        UDim2.new(1, 0, 0, 22), C.blue, Enum.Font.GothamBold)
    recentTitle.LayoutOrder = 6

    local recent = make("Frame", {
        Size = UDim2.new(1, 0, 0, 140),
        BackgroundTransparency = 1,
        LayoutOrder = 7
    }, pageHolder)
    createResultList(recent, cachedResults)
end

local function renderCategories()
    clearPage()

    local intro = label(pageHolder,
        "Choose a category to search ScriptBlox.",
        UDim2.new(1, 0, 0, 38), C.muted)
    intro.LayoutOrder = 1

    local categories = {
        {"🌐  Universal", "universal"},
        {"🏃  Simulator", "simulator"},
        {"👻  Horror", "horror"},
        {"⚔️  Fighting", "fighting"},
        {"🏡  Tycoon", "tycoon"},
        {"🧗  Obby", "obby"},
        {"🚗  Driving", "driving"},
        {"🐾  Pets", "pets"},
        {"💰  Economy", "money"},
        {"🧟  Survival", "survival"}
    }

    for i, item in ipairs(categories) do
        local b = button(pageHolder, item[1] .. "     ›",
            UDim2.new(1, 0, 0, 38), C.card)
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextSize = 11
        b.LayoutOrder = i + 1
        b.Activated:Connect(function()
            renderPage("Search")
            searchScripts(item[2])
        end)
    end
end

local function renderFavorites()
    clearPage()

    local list = {}
    for _, data in pairs(favorites) do
        table.insert(list, data)
    end

    local heading = label(pageHolder, "★  SAVED SCRIPTS  •  " .. #list,
        UDim2.new(1, 0, 0, 24), C.gold, Enum.Font.GothamBold)
    heading.LayoutOrder = 1

    local resultArea = make("Frame", {
        Size = UDim2.new(1, 0, 1, -30),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }, pageHolder)

    createResultList(resultArea, list)
end

local function renderSearch()
    clearPage()

    local heading = label(pageHolder, "⌕  SEARCH RESULTS",
        UDim2.new(1, 0, 0, 24), C.blue, Enum.Font.GothamBold)
    heading.LayoutOrder = 1

    local searchRow = make("Frame", {
        Size = UDim2.new(1, 0, 0, 37),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }, pageHolder)

    local box = make("TextBox", {
        Size = UDim2.new(1, -78, 1, 0),
        BackgroundColor3 = C.panel,
        TextColor3 = C.white,
        PlaceholderColor3 = C.muted,
        PlaceholderText = "Search scripts...",
        Text = currentQuery,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
        BorderSizePixel = 0
    }, searchRow)
    corner(box, 8)

    local go = button(searchRow, "GO",
        UDim2.fromOffset(70, 37), C.purple)
    go.Position = UDim2.new(1, -70, 0, 0)

    local resultArea = make("Frame", {
        Size = UDim2.new(1, 0, 1, -70),
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }, pageHolder)

    createResultList(resultArea, cachedResults)

    local function run()
        local q = box.Text:match("^%s*(.-)%s*$")
        if q ~= "" then searchScripts(q) end
    end
    go.Activated:Connect(run)
    box.FocusLost:Connect(function(enter)
        if enter then run() end
    end)
end

renderPage = function(page)
    currentPage = page
    searchToken += 1
    stopLoading()

    if page == "Home" then
        renderHome()
    elseif page == "Categories" then
        renderCategories()
    elseif page == "Favorites" then
        renderFavorites()
    elseif page == "Search" then
        renderSearch()
    end

    for _, child in ipairs(nav:GetChildren()) do
        if child:IsA("TextButton") then
            local active = child:GetAttribute("Page") == page
            tw(child, 0.15, {
                BackgroundColor3 = active and C.purple or C.panel
            })
        end
    end
end

local navItems = {
    {"⌂", "Home"},
    {"▦", "Categories"},
    {"⌕", "Search"},
    {"★", "Favorites"}
}

make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, nav)

for i, item in ipairs(navItems) do
    local b = button(nav, item[1],
        UDim2.new(0.25, -5, 0, 32), C.panel)
    b.LayoutOrder = i
    b.TextSize = 17
    b:SetAttribute("Page", item[2])
    b.Activated:Connect(function()
        renderPage(item[2])
    end)
end

local fullSize = UDim2.fromOffset(320, 470)

minBtn.Activated:Connect(function()
    if minimized then return end
    minimized = true

    tw(main, 0.28, {
        Size = UDim2.fromOffset(320, 55),
        BackgroundTransparency = 0.1
    }, Enum.EasingStyle.Back)

    task.wait(0.3)
    if not gui.Parent then return end

    main.Visible = false
    restoreBtn.Visible = true
    restoreBtn.Size = UDim2.fromOffset(5, 5)
    tw(restoreBtn, 0.3, {
        Size = UDim2.fromOffset(54, 54)
    }, Enum.EasingStyle.Back)
end)

restoreBtn.Activated:Connect(function()
    if not minimized then return end

    restoreBtn.Visible = false
    main.Visible = true
    main.Size = UDim2.fromOffset(320, 55)

    tw(main, 0.35, {
        Size = fullSize,
        BackgroundTransparency = 0
    }, Enum.EasingStyle.Back)

    minimized = false
end)

closeBtn.Activated:Connect(function()
    tw(main, 0.2, {
        Size = UDim2.fromOffset(280, 50),
        BackgroundTransparency = 1
    })
    task.wait(0.22)
    gui:Destroy()
end)

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local function resize()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local v = camera.ViewportSize
    local w = math.max(250, math.min(350, v.X - 24))
    local h = math.max(320, math.min(500, v.Y - 30))
    fullSize = UDim2.fromOffset(w, h)
    if not minimized then main.Size = fullSize end
end

resize()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")
        :Connect(resize)
end

renderPage("Home")
main.Size = UDim2.fromOffset(250, 350)
main.BackgroundTransparency = 1
tw(main, 0.45, {
    Size = fullSize,
    BackgroundTransparency = 0
}, Enum.EasingStyle.Back)

print("[Script Hub] Loaded for Artin.")
