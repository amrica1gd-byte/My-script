-- ============================================
-- Back Door Scanner v4 (Anti-Obfuscation + Backdoor Detection)
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- ============================================
-- لیست کامل کلمات کلیدی بک‌دور (واقعی)
-- ============================================

local BACKDOOR_PATTERNS = {
    -- ===== اجرا و تزریق (Execution & Injection) =====
    { pattern = "loadstring", risk = "high" },
    { pattern = "load_string", risk = "high" },
    { pattern = "httpget", risk = "high" },
    { pattern = "http_get", risk = "high" },
    { pattern = "http-get", risk = "high" },
    { pattern = "HttpGet", risk = "high" },
    { pattern = "HttpGetAsync", risk = "high" },
    { pattern = "HttpService", risk = "medium" },
    { pattern = "GetAsync", risk = "medium" },
    { pattern = "PostAsync", risk = "medium" },
    { pattern = "RequestAsync", risk = "medium" },
    { pattern = "synapse", risk = "high" },
    { pattern = "synapse.x", risk = "high" },
    { pattern = "krnl", risk = "high" },
    { pattern = "scriptware", risk = "high" },
    { pattern = "script-ware", risk = "high" },
    { pattern = "wearedevs", risk = "high" },
    { pattern = "wearedevs.net", risk = "high" },
    { pattern = "executor", risk = "high" },
    { pattern = "execute", risk = "medium" },
    { pattern = "getfenv", risk = "medium" },
    { pattern = "setfenv", risk = "medium" },
    { pattern = "getgenv", risk = "medium" },
    { pattern = "setgenv", risk = "medium" },
    { pattern = "getrenv", risk = "medium" },
    { pattern = "setrenv", risk = "medium" },
    { pattern = "getreg", risk = "medium" },
    { pattern = "setreg", risk = "medium" },
    { pattern = "getsenv", risk = "medium" },
    { pattern = "setsenv", risk = "medium" },
    { pattern = "debug.getupvalue", risk = "medium" },
    { pattern = "debug.setupvalue", risk = "medium" },
    { pattern = "debug.getinfo", risk = "low" },
    { pattern = "debug.getregistry", risk = "low" },
    { pattern = "pcall", risk = "low" },
    { pattern = "xpcall", risk = "low" },
    { pattern = "coroutine", risk = "low" },
    { pattern = "task.wait", risk = "low" },
    { pattern = "task.spawn", risk = "low" },
    { pattern = "task.delay", risk = "low" },
    { pattern = "task.defer", risk = "low" },
    { pattern = "task.sync", risk = "low" },
    { pattern = "delay", risk = "low" },
    { pattern = "spawn", risk = "low" },
    { pattern = "wait", risk = "low" },
    
    -- ===== شبکه و ارتباطات (Networking) =====
    { pattern = "webhook", risk = "high" },
    { pattern = "web_hook", risk = "high" },
    { pattern = "discord", risk = "medium" },
    { pattern = "discord.com", risk = "medium" },
    { pattern = "discordapp.com", risk = "medium" },
    { pattern = "discord.gg", risk = "medium" },
    { pattern = "https://", risk = "high" },
    { pattern = "http://", risk = "high" },
    { pattern = ".com", risk = "low" },
    { pattern = ".net", risk = "low" },
    { pattern = ".org", risk = "low" },
    { pattern = ".xyz", risk = "medium" },
    { pattern = ".rocks", risk = "medium" },
    { pattern = ".club", risk = "medium" },
    { pattern = ".online", risk = "medium" },
    { pattern = ".top", risk = "medium" },
    { pattern = ".site", risk = "medium" },
    { pattern = ".host", risk = "medium" },
    { pattern = ".cloud", risk = "medium" },
    { pattern = ".space", risk = "medium" },
    { pattern = ".tech", risk = "medium" },
    { pattern = ".store", risk = "medium" },
    { pattern = ".app", risk = "medium" },
    { pattern = ".dev", risk = "medium" },
    { pattern = ".io", risk = "medium" },
    { pattern = ".gg", risk = "medium" },
    { pattern = ".me", risk = "medium" },
    { pattern = ".us", risk = "medium" },
    { pattern = ".eu", risk = "medium" },
    { pattern = "send", risk = "low" },
    { pattern = "post", risk = "low" },
    { pattern = "request", risk = "medium" },
    { pattern = "fetch", risk = "medium" },
    { pattern = "sync", risk = "low" },
    { pattern = "upload", risk = "low" },
    { pattern = "download", risk = "low" },
    { pattern = "socket", risk = "high" },
    { pattern = "websocket", risk = "high" },
    { pattern = "tcp", risk = "high" },
    { pattern = "udp", risk = "high" },
    { pattern = "ip", risk = "low" },
    { pattern = "port", risk = "low" },
    { pattern = "proxy", risk = "medium" },
    { pattern = "vpn", risk = "medium" },
    { pattern = "tor", risk = "medium" },
    { pattern = "onion", risk = "medium" },
    { pattern = "payload", risk = "medium" },
    { pattern = "callback", risk = "medium" },
    { pattern = "hook", risk = "medium" },
    { pattern = "inject", risk = "high" },
    { pattern = "injection", risk = "high" },
    { pattern = "intercept", risk = "medium" },
    { pattern = "sniff", risk = "medium" },
    { pattern = "spy", risk = "medium" },
    
    -- ===== Remote ها (بک‌دورهای واقعی) =====
    { pattern = "FireServer", risk = "medium" },
    { pattern = "FireAllClients", risk = "medium" },
    { pattern = "InvokeServer", risk = "medium" },
    { pattern = "RemoteEvent", risk = "low" },
    { pattern = "RemoteFunction", risk = "low" },
    { pattern = "UnreliableRemoteEvent", risk = "low" },
    { pattern = "OnServerEvent", risk = "medium" },
    { pattern = "OnClientEvent", risk = "medium" },
    { pattern = ":FireServer", risk = "medium" },
    { pattern = ":InvokeServer", risk = "medium" },
    { pattern = ":FireClient", risk = "medium" },
    { pattern = ":InvokeClient", risk = "medium" },
    { pattern = "remote", risk = "low" },
    { pattern = "remoteevent", risk = "low" },
    { pattern = "remotefunction", risk = "low" },
    { pattern = "bind", risk = "low" },
    { pattern = "unbind", risk = "low" },
    { pattern = "trigger", risk = "low" },
    { pattern = "emit", risk = "low" },
    { pattern = "broadcast", risk = "low" },
    { pattern = "multicast", risk = "low" },
    { pattern = "unicast", risk = "low" },
}
    -- ===== پنهان‌سازی (Hiding) =====
    { pattern = "gethui", risk = "medium" },
    { pattern = "get_hui", risk = "medium" },
    { pattern = "sethidden", risk = "medium" },
    { pattern = "set_hidden", risk = "medium" },
    { pattern = "makehidden", risk = "medium" },
    { pattern = "make_hidden", risk = "medium" },
    { pattern = "hidden", risk = "low" },
    { pattern = "hide", risk = "low" },
    { pattern = "show", risk = "low" },
    { pattern = "visible", risk = "low" },
    { pattern = "invisible", risk = "low" },
    { pattern = "getallchildren", risk = "low" },
    { pattern = "get_descendants", risk = "low" },
    { pattern = "getdescendants", risk = "low" },
    { pattern = "waitforchild", risk = "low" },
    { pattern = "findfirstchild", risk = "low" },
    { pattern = "findfirstchildofclass", risk = "low" },
    { pattern = "findfirstchildwhichisaclass", risk = "low" },
    { pattern = "clone", risk = "low" },
    { pattern = "duplicate", risk = "low" },
    { pattern = "copy", risk = "low" },
    { pattern = "move", risk = "low" },
    { pattern = "parent", risk = "low" },
    
    -- ===== هک و دور زدن (Hacking & Bypass) =====
    { pattern = "bypass", risk = "high" },
    { pattern = "bypassing", risk = "high" },
    { pattern = "bypasses", risk = "high" },
    { pattern = "spoof", risk = "high" },
    { pattern = "spoofing", risk = "high" },
    { pattern = "spoofer", risk = "high" },
    { pattern = "exploit", risk = "high" },
    { pattern = "exploits", risk = "high" },
    { pattern = "exploiting", risk = "high" },
    { pattern = "hack", risk = "high" },
    { pattern = "hacks", risk = "high" },
    { pattern = "hacking", risk = "high" },
    { pattern = "cheat", risk = "high" },
    { pattern = "cheats", risk = "high" },
    { pattern = "cheating", risk = "high" },
    { pattern = "crack", risk = "high" },
    { pattern = "cracks", risk = "high" },
    { pattern = "cracked", risk = "high" },
    { pattern = "godmode", risk = "medium" },
    { pattern = "god_mode", risk = "medium" },
    { pattern = "noclip", risk = "medium" },
    { pattern = "no_clip", risk = "medium" },
    { pattern = "speedhack", risk = "medium" },
    { pattern = "speed_hack", risk = "medium" },
    { pattern = "aimbot", risk = "medium" },
    { pattern = "aim_bot", risk = "medium" },
    { pattern = "wallhack", risk = "medium" },
    { pattern = "wall_hack", risk = "medium" },
    { pattern = "esp", risk = "medium" },
    { pattern = "chams", risk = "medium" },
    { pattern = "glow", risk = "medium" },
    { pattern = "highlight", risk = "medium" },
    { pattern = "tracer", risk = "medium" },
    { pattern = "triggerbot", risk = "medium" },
    { pattern = "trigger_bot", risk = "medium" },
    { pattern = "antiban", risk = "medium" },
    { pattern = "anti_ban", risk = "medium" },
    { pattern = "unban", risk = "medium" },
    { pattern = "banproof", risk = "medium" },
    { pattern = "ban_proof", risk = "medium" },
    { pattern = "unlimited", risk = "low" },
    { pattern = "infinite", risk = "low" },
    { pattern = "auto", risk = "low" },
    { pattern = "farm", risk = "low" },
    { pattern = "autofarm", risk = "low" },
    { pattern = "auto_farm", risk = "low" },
    { pattern = "macro", risk = "low" },
    { pattern = "script", risk = "low" },
    
    -- ===== مبهم‌سازی (Obfuscation - برای تشخیص کدهای مبهم) =====
    { pattern = "string.char", risk = "medium" },
    { pattern = "string.byte", risk = "medium" },
    { pattern = "string.gsub", risk = "low" },
    { pattern = "string.gmatch", risk = "low" },
    { pattern = "string.match", risk = "low" },
    { pattern = "string.find", risk = "low" },
    { pattern = "string.sub", risk = "low" },
    { pattern = "string.len", risk = "low" },
    { pattern = "string.rep", risk = "low" },
    { pattern = "string.reverse", risk = "low" },
    { pattern = "string.lower", risk = "low" },
    { pattern = "string.upper", risk = "low" },
    { pattern = "table.concat", risk = "medium" },
    { pattern = "table.insert", risk = "low" },
    { pattern = "table.remove", risk = "low" },
    { pattern = "table.sort", risk = "low" },
    { pattern = "table.pack", risk = "low" },
    { pattern = "table.unpack", risk = "low" },
    { pattern = "table.move", risk = "low" },
    { pattern = "table.foreach", risk = "low" },
    { pattern = "table.foreachi", risk = "low" },
    { pattern = "bit32", risk = "low" },
    { pattern = "bit", risk = "low" },
    { pattern = "math.random", risk = "low" },
    { pattern = "math.floor", risk = "low" },
    { pattern = "math.ceil", risk = "low" },
    { pattern = "math.abs", risk = "low" },
    { pattern = "math.min", risk = "low" },
    { pattern = "math.max", risk = "low" },
    
    -- ===== الگوهای مبهم‌سازی WeAreDevs =====
    { pattern = "return(function(...)local", risk = "high" }, -- WeAreDevs header
    { pattern = "local O={", risk = "high" }, -- WeAreDevs string table
    { pattern = 'function s(s)return O[s-', risk = "high" }, -- WeAreDevs deobf function
    { pattern = 'local function s(s)return O[s-', risk = "high" },
    { pattern = "for s,h in ipairs({", risk = "medium" },
    { pattern = "do local s=table.concat", risk = "medium" },
    { pattern = "local j=type local Y=table.insert", risk = "medium" },
    { pattern = "local W=math.floor", risk = "medium" },
    { pattern = "local P=string.len", risk = "medium" },
    { pattern = "local V=string.char", risk = "medium" },
    { pattern = "m[O]=s(I)", risk = "medium" },
    { pattern = "return(function(O,g,j,Y,W,P,m,l,p,J,w,K,H,y,D,I,e,v,V,E,h,C,f,d)C,y,v,E,J,l,f,e,H,K,I,p,d,D,w,V,h=function(O,s)", risk = "high" }, -- WeAreDevs main function
    { pattern = "getfenv and getfenv()or _ENV", risk = "medium" },
    { pattern = "unpack or table[s(", risk = "medium" },
}
    -- ===== نام‌های مشکوک =====
    { pattern = "backdoor", risk = "high" },
    { pattern = "back_door", risk = "high" },
    { pattern = "back-door", risk = "high" },
    { pattern = "remoteaccess", risk = "high" },
    { pattern = "remote_access", risk = "high" },
    { pattern = "remote-access", risk = "high" },
    { pattern = "adminpanel", risk = "high" },
    { pattern = "admin_panel", risk = "high" },
    { pattern = "admin-panel", risk = "high" },
    { pattern = "serverexec", risk = "high" },
    { pattern = "server_exec", risk = "high" },
    { pattern = "server-exec", risk = "high" },
    { pattern = "serverside", risk = "high" },
    { pattern = "server_side", risk = "high" },
    { pattern = "server-side", risk = "high" },
    { pattern = "cmds", risk = "medium" },
    { pattern = "commands", risk = "medium" },
    { pattern = "command", risk = "medium" },
    { pattern = "admin", risk = "low" },
    { pattern = "mod", risk = "low" },
    { pattern = "moderator", risk = "low" },
    { pattern = "owner", risk = "low" },
    { pattern = "god", risk = "low" },
    { pattern = "op", risk = "low" },
    { pattern = "superuser", risk = "low" },
    { pattern = "root", risk = "low" },
    { pattern = "system", risk = "low" },
    
    -- ===== امنیت و آنتی‌بک‌دور =====
    { pattern = "antivirus", risk = "low" },
    { pattern = "anti_virus", risk = "low" },
    { pattern = "antihack", risk = "low" },
    { pattern = "anti_hack", risk = "low" },
    { pattern = "scan", risk = "low" },
    { pattern = "scanner", risk = "low" },
    { pattern = "protect", risk = "low" },
    { pattern = "protection", risk = "low" },
    { pattern = "secure", risk = "low" },
    { pattern = "security", risk = "low" },
    { pattern = "safety", risk = "low" },
    { pattern = "safe", risk = "low" },
    { pattern = "detect", risk = "low" },
    { pattern = "detection", risk = "low" },
    { pattern = "monitor", risk = "low" },
    { pattern = "log", risk = "low" },
    { pattern = "logs", risk = "low" },
    { pattern = "check", risk = "low" },
    { pattern = "verify", risk = "low" },
    { pattern = "validation", risk = "low" },
    { pattern = "audit", risk = "low" },
    { pattern = "trace", risk = "low" },
    { pattern = "debug", risk = "low" },
    
    -- ===== حریم خصوصی و داده‌ها =====
    { pattern = "cookie", risk = "medium" },
    { pattern = "token", risk = "medium" },
    { pattern = "auth", risk = "medium" },
    { pattern = "authentication", risk = "medium" },
    { pattern = "authorization", risk = "medium" },
    { pattern = "session", risk = "medium" },
    { pattern = "login", risk = "low" },
    { pattern = "logout", risk = "low" },
    { pattern = "password", risk = "medium" },
    { pattern = "pass", risk = "medium" },
    { pattern = "key", risk = "medium" },
    { pattern = "keys", risk = "medium" },
    { pattern = "license", risk = "medium" },
    { pattern = "licenses", risk = "medium" },
    { pattern = "crypto", risk = "medium" },
    { pattern = "encrypt", risk = "medium" },
    { pattern = "decrypt", risk = "medium" },
    { pattern = "hash", risk = "low" },
    { pattern = "md5", risk = "low" },
    { pattern = "sha1", risk = "low" },
    { pattern = "sha256", risk = "low" },
    { pattern = "base64", risk = "low" },
    { pattern = "json", risk = "low" },
    { pattern = "xml", risk = "low" },
    { pattern = "yaml", risk = "low" },
    { pattern = "toml", risk = "low" },
    
    -- ===== کلاس‌های مشکوک =====
    { pattern = "Script", risk = "low" },
    { pattern = "LocalScript", risk = "low" },
    { pattern = "ModuleScript", risk = "low" },
    { pattern = "StringValue", risk = "low" },
    { pattern = "BoolValue", risk = "low" },
    { pattern = "NumberValue", risk = "low" },
    { pattern = "ObjectValue", risk = "low" },
    { pattern = "Folder", risk = "low" },
    { pattern = "Model", risk = "low" },
    
    -- ===== سرویس‌های خاص =====
    { pattern = "HttpService", risk = "medium" },
    { pattern = "TeleportService", risk = "low" },
    { pattern = "MarketplaceService", risk = "low" },
    { pattern = "DataStoreService", risk = "low" },
    { pattern = "MessagingService", risk = "low" },
    { pattern = "ReplicatedStorage", risk = "low" },
    { pattern = "ServerStorage", risk = "low" },
    { pattern = "ServerScriptService", risk = "low" },
    { pattern = "Workspace", risk = "low" },
    { pattern = "Lighting", risk = "low" },
    { pattern = "SoundService", risk = "low" },
    { pattern = "TweenService", risk = "low" },
    { pattern = "RunService", risk = "low" },
    
    -- ===== متفرقه =====
    { pattern = "dofile", risk = "low" },
    { pattern = "loadfile", risk = "low" },
}

-- ============================================
-- تشخیص اسکریپت‌های مبهم (Obfuscated)
-- ============================================

local function isObfuscated(source)
    if not source then return false, "No source" end
    
    local score = 0
    local reasons = {}
    
    -- 1. بررسی هدر WeAreDevs
    if source:find("return(function(...)local O={", 1, true) then
        score = score + 50
        table.insert(reasons, "WeAreDevs header detected")
    end
    
    -- 2. بررسی تابع s
    if source:find('function s(s)return O[s-', 1, true) then
        score = score + 30
        table.insert(reasons, "Deobfuscation function 's' detected")
    end
    
    -- 3. بررسی الگوهای مبهم‌سازی
    local obfPatterns = {
        'local O={',
        'local function s(s)return O',
        'for s,h in ipairs',
        'do local s=table.concat',
        'local j=type local Y=table.insert',
        'local V=string.char',
        'm[O]=s(I)',
        'getfenv and getfenv()or _ENV',
        'unpack or table[s(',
    }
    
    for _, pattern in ipairs(obfPatterns) do
        if source:find(pattern, 1, true) then
            score = score + 15
            table.insert(reasons, "Obfuscation pattern: " .. pattern)
        end
    end
    
    -- 4. بررسی طول کد (کدهای مبهم معمولاً طولانی‌تر از 5000 کاراکتر هستند)
    if #source > 5000 then
        score = score + 10
        table.insert(reasons, "Long code (>5000 chars)")
    end
    
    -- 5. بررسی وجود رشته‌های عددی با backslash
    if source:find('"\\%d+\\%d+\\%d+"', 1) then
        score = score + 15
        table.insert(reasons, "Numeric string patterns detected")
    end
    
    -- 6. بررسی وجود آرایه‌های بزرگ از رشته‌ها
    if source:find('{"[^"]*","[^"]*","[^"]*","[^"]*"}', 1) then
        score = score + 10
        table.insert(reasons, "Large string array detected")
    end
    
    -- نتیجه‌گیری
    if score >= 30 then
        return true, reasons
    else
        return false, reasons
    end
end
-- ============================================
-- GUI اصلی اسکنر
-- ============================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BackDoorScanner"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(200, 50, 50)

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 36)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
header.BorderSizePixel = 0
header.Parent = mainFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔍 Back Door Scanner v4"
title.TextColor3 = Color3.fromRGB(255, 80, 80)
title.TextSize = 15
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
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0.9, 0, 0, 42)
scanBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
scanBtn.Text = "🕵️ اسکن بک‌دور (با تشخیص مبهم)"
scanBtn.TextColor3 = Color3.new(1, 1, 1)
scanBtn.TextSize = 15
scanBtn.Font = Enum.Font.GothamBold
scanBtn.Parent = mainFrame
Instance.new("UICorner", scanBtn).CornerRadius = UDim.new(0, 8)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0.82, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "✅ آماده اسکن"
statusLabel.TextColor3 = Color3.fromRGB(150, 200, 150)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- ============================================
-- سیستم درگ
-- ============================================
local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ============================================
-- تابع اسکن
-- ============================================

local function scanForBackdoors()
    statusLabel.Text = "🔄 در حال اسکن..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    scanBtn.Enabled = false

    local results = {}
    local totalChecked = 0
    local maxCheck = 50000

    local function checkString(text, sourceType, name, path)
        if not text then return end
        local textLower = text:lower()
        
        for _, pattern in ipairs(BACKDOOR_PATTERNS) do
            if textLower:find(pattern.pattern, 1, true) then
                table.insert(results, {
                    Name = name,
                    Type = sourceType,
                    Path = path,
                    Pattern = pattern.pattern,
                    Risk = pattern.risk,
                    Reason = "کلمه کلیدی: " .. pattern.pattern
                })
                return true
            end
        end
        return false
    end

    local function scanObject(obj, path)
        if totalChecked >= maxCheck then return end
        totalChecked = totalChecked + 1

        if obj.Name then
            checkString(obj.Name, "Name", obj.Name, path)
        end

        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            local success, source = pcall(function()
                return obj.Source
            end)
            if success and source then
                -- بررسی مبهم بودن
                local obfuscated, reasons = isObfuscated(source)
                if obfuscated then
                    table.insert(results, {
                        Name = obj.Name,
                        Type = obj.ClassName,
                        Path = path,
                        Pattern = "OBFUSCATED",
                        Risk = "high",
                        Reason = "🔴 اسکریپت مبهم (Obfuscated) - احتمال بک‌دور:\n" .. table.concat(reasons, "\n")
                    })
                end
                -- بررسی کلمات کلیدی
                checkString(source, "Source", obj.Name, path)
            end
        end

        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(results, {
                Name = obj.Name,
                Type = obj.ClassName,
                Path = path,
                Pattern = "Remote",
                Risk = "medium",
                Reason = "RemoteObject شناسایی شد (نام: " .. obj.Name .. ")"
            })
        end

        if obj:IsA("StringValue") then
            checkString(obj.Value, "Value", obj.Name, path)
        end

        for _, child in ipairs(obj:GetChildren()) do
            if totalChecked >= maxCheck then break end
            scanObject(child, path .. child.Name .. " > ")
        end
    end

    scanObject(game, "")

    local hasBackdoor = #results > 0

    if totalChecked >= maxCheck then
        statusLabel.Text = "✅ اسکن کامل شد (۵۰۰۰۰ شی)"
    else
        statusLabel.Text = "✅ اسکن کامل شد (" .. totalChecked .. " شی)"
    end
    statusLabel.TextColor3 = Color3.fromRGB(150, 200, 150)
    scanBtn.Enabled = true

    showResult(hasBackdoor, results)
end
-- ============================================
-- GUI نتیجه
-- ============================================

local function showResult(found, results)
    local resultGui = Instance.new("ScreenGui")
    resultGui.Name = "ScanResult"
    resultGui.ResetOnSpawn = false
    resultGui.Parent = player:WaitForChild("PlayerGui")

    local resultFrame = Instance.new("Frame")
    resultFrame.Size = UDim2.new(0, 450, 0, 350)
    resultFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    resultFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    resultFrame.BorderSizePixel = 0
    resultFrame.ClipsDescendants = true
    resultFrame.Parent = resultGui

    Instance.new("UICorner", resultFrame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", resultFrame).Color = found and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 255, 50)

    local rHeader = Instance.new("Frame")
    rHeader.Size = UDim2.new(1, 0, 0, 36)
    rHeader.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    rHeader.BorderSizePixel = 0
    rHeader.Parent = resultFrame
    Instance.new("UICorner", rHeader).CornerRadius = UDim.new(0, 12)

    local rTitle = Instance.new("TextLabel")
    rTitle.Size = UDim2.new(1, -40, 1, 0)
    rTitle.Position = UDim2.new(0, 8, 0, 0)
    rTitle.BackgroundTransparency = 1
    rTitle.Text = "📊 نتیجه اسکن"
    rTitle.TextColor3 = Color3.fromRGB(50, 255, 50)
    rTitle.TextSize = 15
    rTitle.Font = Enum.Font.GothamBold
    rTitle.TextXAlignment = Enum.TextXAlignment.Left
    rTitle.Parent = rHeader

    local rClose = Instance.new("TextButton")
    rClose.Size = UDim2.new(0, 24, 0, 24)
    rClose.Position = UDim2.new(1, -30, 0.5, -12)
    rClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    rClose.Text = "✕"
    rClose.TextColor3 = Color3.new(1, 1, 1)
    rClose.TextSize = 14
    rClose.Font = Enum.Font.GothamBold
    rClose.Parent = rHeader
    Instance.new("UICorner", rClose).CornerRadius = UDim.new(0, 6)
    rClose.MouseButton1Click:Connect(function() resultGui:Destroy() end)

    local resultLabel = Instance.new("TextLabel")
    resultLabel.Size = UDim2.new(1, -20, 0, 45)
    resultLabel.Position = UDim2.new(0, 10, 0.12, 0)
    resultLabel.BackgroundTransparency = 1
    if found then
        resultLabel.Text = "⚠️ بک‌دور پیدا شد!"
        resultLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    else
        resultLabel.Text = "✅ بک‌دوری پیدا نشد"
        resultLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
    end
    resultLabel.TextSize = 24
    resultLabel.Font = Enum.Font.GothamBold
    resultLabel.Parent = resultFrame

    local detailLabel = Instance.new("TextLabel")
    detailLabel.Size = UDim2.new(1, -20, 0, 220)
    detailLabel.Position = UDim2.new(0, 10, 0.32, 0)
    detailLabel.BackgroundTransparency = 1
    detailLabel.TextWrapped = true
    detailLabel.TextScaled = false
    detailLabel.TextSize = 12
    detailLabel.Font = Enum.Font.Gotham
    detailLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    detailLabel.TextXAlignment = Enum.TextXAlignment.Left
    detailLabel.TextYAlignment = Enum.TextYAlignment.Top

    if found and #results > 0 then
        local detailText = "🔴 دلیل بک‌دور:\n\n"
        for i, res in ipairs(results) do
            local riskIcon = res.Risk == "high" and "🔴" or res.Risk == "medium" and "🟡" or "🟢"
            detailText = detailText .. string.format("%d. %s %s (%s)\n   📍 %s\n   ⚠️ %s\n\n",
                i, riskIcon, res.Name, res.Type, res.Path, res.Reason)
            if i >= 8 then
                detailText = detailText .. "... و " .. (#results - 8) .. " مورد دیگر"
                break
            end
        end
        detailLabel.Text = detailText
    else
        detailLabel.Text = "هیچ بک‌دوری در بازی یافت نشد.\n✅ بازی شما امن است."
    end
    detailLabel.Parent = resultFrame

    local rDragging = false
    local rDragStart, rStartPos

    rHeader.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            rDragging = true
            rDragStart = input.Position
            rStartPos = resultFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if rDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - rDragStart
            resultFrame.Position = UDim2.new(
                rStartPos.X.Scale,
                rStartPos.X.Offset + delta.X,
                rStartPos.Y.Scale,
                rStartPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            rDragging = false
        end
    end)
end

scanBtn.MouseButton1Click:Connect(scanForBackdoors)
