--[[
    Elyx Hub V1 · All Scripts
    Steal an Egg · Loading 1-4 · Blur · Open/Close
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)

pcall(function()
    local function wipe(p)
        if p and p:FindFirstChild("ElyxHubV1") then p.ElyxHubV1:Destroy() end
    end
    wipe(CoreGui)
    wipe(LocalPlayer:FindFirstChild("PlayerGui"))
    if gethui then wipe(gethui()) end
    local b = Lighting:FindFirstChild("ElyxV1Blur")
    if b then b:Destroy() end
end)

local function getParent()
    local ok, h = pcall(function() return gethui and gethui() end)
    if ok and h then return h end
    local pg = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 4)
    if pg then return pg end
    return CoreGui
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ElyxHubV1"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = getParent()

local blur = Instance.new("BlurEffect")
blur.Name = "ElyxV1Blur"
blur.Size = 0
pcall(function() blur.Parent = Lighting end)

-- ========== LOADING ==========
local Loading = Instance.new("Frame")
Loading.Size = UDim2.new(1, 0, 1, 0)
Loading.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Loading.BorderSizePixel = 0
Loading.Parent = ScreenGui

-- Logo text style (Elyx white + Hubs blue glow)
local LogoTop = Instance.new("TextLabel")
LogoTop.Size = UDim2.new(1, 0, 0, 70)
LogoTop.Position = UDim2.new(0, 0, 0.28, 0)
LogoTop.BackgroundTransparency = 1
LogoTop.Text = "Elyx"
LogoTop.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoTop.TextSize = 56
LogoTop.Font = Enum.Font.GothamBlack
LogoTop.Parent = Loading

local LogoBot = Instance.new("TextLabel")
LogoBot.Size = UDim2.new(1, 0, 0, 40)
LogoBot.Position = UDim2.new(0, 0, 0.28, 58)
LogoBot.BackgroundTransparency = 1
LogoBot.Text = "Hubs"
LogoBot.TextColor3 = Color3.fromRGB(0, 140, 255)
LogoBot.TextSize = 36
LogoBot.Font = Enum.Font.GothamBlack
LogoBot.Parent = Loading

local HubName = Instance.new("TextLabel")
HubName.Size = UDim2.new(1, 0, 0, 24)
HubName.Position = UDim2.new(0, 0, 0.42, 0)
HubName.BackgroundTransparency = 1
HubName.Text = "elyx hub V1 all script's"
HubName.TextColor3 = Color3.fromRGB(180, 190, 220)
HubName.TextSize = 14
HubName.Font = Enum.Font.Gotham
HubName.Parent = Loading

local LCount = Instance.new("TextLabel")
LCount.Size = UDim2.new(1, 0, 0, 50)
LCount.Position = UDim2.new(0, 0, 0.52, 0)
LCount.BackgroundTransparency = 1
LCount.Text = "1"
LCount.TextColor3 = Color3.fromRGB(0, 160, 255)
LCount.TextSize = 42
LCount.Font = Enum.Font.GothamBold
LCount.Parent = Loading

for i = 1, 4 do
    LCount.Text = tostring(i)
    task.wait(0.45)
end
task.wait(0.35)
Loading:Destroy()

-- ========== MAIN ==========
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 320)
Main.Position = UDim2.new(0.5, -240, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BackgroundTransparency = 0.22
Main.BorderSizePixel = 0
Main.Visible = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
local ms = Instance.new("UIStroke", Main)
ms.Color = Color3.fromRGB(0, 120, 255)
ms.Thickness = 1.5
ms.Transparency = 0.35

if blur then pcall(function() blur.Size = 14 end) end

-- Top bar
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 40)
Top.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
Top.BackgroundTransparency = 0.3
Top.BorderSizePixel = 0
Top.Parent = Main
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 14)

local TopTitle = Instance.new("TextLabel")
TopTitle.Size = UDim2.new(1, -50, 1, 0)
TopTitle.Position = UDim2.new(0, 14, 0, 0)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "Elyx Hub V1 · All Scripts"
TopTitle.TextColor3 = Color3.fromRGB(240, 245, 255)
TopTitle.TextSize = 15
TopTitle.Font = Enum.Font.GothamBold
TopTitle.TextXAlignment = Enum.TextXAlignment.Left
TopTitle.Parent = Top

local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 52, 0, 28)
HideBtn.Position = UDim2.new(0, 14, 0.5, -14)
HideBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
HideBtn.Text = "Hide"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.TextSize = 12
HideBtn.Font = Enum.Font.GothamBold
HideBtn.Parent = ScreenGui
Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0, 8)

local isHidden = false
HideBtn.MouseButton1Click:Connect(function()
    if not isHidden then
        Main.Visible = false
        HideBtn.Text = "Open"
        HideBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        if blur then pcall(function() blur.Size = 0 end) end
        isHidden = true
    else
        Main.Visible = true
        HideBtn.Text = "Hide"
        HideBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
        if blur then pcall(function() blur.Size = 14 end) end
        isHidden = false
    end
end)

-- Sidebar
local Side = Instance.new("Frame")
Side.Size = UDim2.new(0, 110, 1, -48)
Side.Position = UDim2.new(0, 8, 0, 44)
Side.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
Side.BackgroundTransparency = 0.15
Side.BorderSizePixel = 0
Side.Parent = Main
Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 10)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -130, 1, -52)
Content.Position = UDim2.new(0, 124, 0, 46)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Groups = {}
local function CreateGroup(name)
    local f = Instance.new("ScrollingFrame")
    f.Name = name
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ScrollBarThickness = 4
    f.ScrollBarImageColor3 = Color3.fromRGB(0, 140, 255)
    f.Visible = false
    f.CanvasSize = UDim2.new(0, 0, 0, 0)
    f.Parent = Content
    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0, 6)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Parent = f
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        f.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 14)
    end)
    Groups[name] = f
    return f
end

local function Switch(name)
    for n, g in pairs(Groups) do g.Visible = (n == name) end
end

local function SideBtn(text, order, group)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 30)
    b.Position = UDim2.new(0, 6, 0, 8 + order * 36)
    b.BackgroundColor3 = Color3.fromRGB(28, 30, 42)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(220, 230, 255)
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.Parent = Side
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() Switch(group) end)
end

SideBtn("Profile", 0, "Profile")
SideBtn("Theme", 1, "Theme")
SideBtn("Scripts", 2, "Scripts")
SideBtn("Finder", 3, "Finder")
SideBtn("Live Chat", 4, "Chat")
SideBtn("Settings", 5, "Settings")

-- ===== 1 PROFILE =====
local ProfileG = CreateGroup("Profile")
do
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 22)
    t.BackgroundTransparency = 1
    t.Text = "Your Profile"
    t.TextColor3 = Color3.fromRGB(0, 180, 255)
    t.TextSize = 14
    t.Font = Enum.Font.GothamBold
    t.Parent = ProfileG

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 72, 0, 72)
    avatar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png"
    avatar.Parent = ProfileG
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

    local uname = Instance.new("TextLabel")
    uname.Size = UDim2.new(1, 0, 0, 22)
    uname.BackgroundTransparency = 1
    uname.Text = "@" .. LocalPlayer.Name
    uname.TextColor3 = Color3.fromRGB(255, 255, 255)
    uname.TextSize = 15
    uname.Font = Enum.Font.GothamBold
    uname.Parent = ProfileG

    local disp = Instance.new("TextLabel")
    disp.Size = UDim2.new(1, 0, 0, 18)
    disp.BackgroundTransparency = 1
    disp.Text = "Display: " .. (LocalPlayer.DisplayName or LocalPlayer.Name)
    disp.TextColor3 = Color3.fromRGB(180, 190, 210)
    disp.TextSize = 12
    disp.Font = Enum.Font.Gotham
    disp.Parent = ProfileG

    local uid = Instance.new("TextLabel")
    uid.Size = UDim2.new(1, 0, 0, 18)
    uid.BackgroundTransparency = 1
    uid.Text = "UserId: " .. tostring(LocalPlayer.UserId)
    uid.TextColor3 = Color3.fromRGB(150, 160, 180)
    uid.TextSize = 12
    uid.Font = Enum.Font.Gotham
    uid.Parent = ProfileG

    local openProf = Instance.new("TextButton")
    openProf.Size = UDim2.new(0.9, 0, 0, 30)
    openProf.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    openProf.Text = "Copy Profile Link"
    openProf.TextColor3 = Color3.fromRGB(255, 255, 255)
    openProf.TextSize = 12
    openProf.Font = Enum.Font.GothamBold
    openProf.Parent = ProfileG
    Instance.new("UICorner", openProf).CornerRadius = UDim.new(0, 8)
    openProf.MouseButton1Click:Connect(function()
        local link = "https://www.roblox.com/users/" .. LocalPlayer.UserId .. "/profile"
        pcall(function() setclipboard(link) end)
        openProf.Text = "Copied!"
        task.wait(1.2)
        openProf.Text = "Copy Profile Link"
    end)
end

-- ===== 2 THEME =====
local ThemeG = CreateGroup("Theme")
do
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 22)
    t.BackgroundTransparency = 1
    t.Text = "Text Color"
    t.TextColor3 = Color3.fromRGB(0, 180, 255)
    t.TextSize = 14
    t.Font = Enum.Font.GothamBold
    t.Parent = ThemeG

    local function ColorBtn(name, col)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.9, 0, 0, 28)
        b.BackgroundColor3 = col
        b.Text = name
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 12
        b.Font = Enum.Font.GothamBold
        b.Parent = ThemeG
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(function()
            for _, v in pairs(Main:GetDescendants()) do
                if (v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox")) and v ~= b then
                    v.TextColor3 = col
                end
            end
        end)
    end
    ColorBtn("Blue", Color3.fromRGB(0, 160, 255))
    ColorBtn("White", Color3.fromRGB(240, 245, 255))
    ColorBtn("Cyan", Color3.fromRGB(80, 220, 255))
    ColorBtn("Purple", Color3.fromRGB(180, 120, 255))
    ColorBtn("Green", Color3.fromRGB(80, 255, 160))
    ColorBtn("Pink", Color3.fromRGB(255, 120, 200))
end

local function MakeRun(parent, name, code)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.98, 0, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
    b.Text = "  ▶  " .. name
    b.TextColor3 = Color3.fromRGB(220, 230, 255)
    b.TextSize = 11
    b.Font = Enum.Font.Gotham
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    b.MouseButton1Click:Connect(function()
        b.Text = "  ...  " .. name
        local ok = pcall(function() loadstring(code)() end)
        b.Text = ok and ("  ✓  " .. name) or ("  ✗  " .. name)
        b.BackgroundColor3 = ok and Color3.fromRGB(30, 70, 45) or Color3.fromRGB(90, 35, 35)
        task.wait(1.4)
        b.Text = "  ▶  " .. name
        b.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
    end)
end

-- ===== 3 SCRIPTS (Sources Hub) =====
local ScriptsG = CreateGroup("Scripts")
do
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 20)
    t.BackgroundTransparency = 1
    t.Text = "Steal an Egg · Sources Hub"
    t.TextColor3 = Color3.fromRGB(0, 200, 120)
    t.TextSize = 13
    t.Font = Enum.Font.GothamBold
    t.Parent = ScriptsG

    local list = {
        {"Josh Bns", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Dayvinksthik/Script/refs/heads/main/Games/JoshBNS-Crack.lua"))()'},
        {"Shaders", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/swaggayoung581-sudo/special-computing-machine/refs/heads/main/SAE_HUB_MENU_SKY_ACCESSORY_ANIM_FIXED_FOV_ANIM_COMPACT_SAVE_CONFIG.lua%20(1).txt"))()'},
        {"Anti Hit / Anti Chase", 'loadstring(game:HttpGet("https://gist.githubusercontent.com/virexx55/836653079c73281295d6bfb5c10be5d9/raw/128b0220c9a36354b5c6504c3669f328e5354805/virex.lua"))()'},
        {"Nexora Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Dayvinksthik/Script/refs/heads/main/Games/JoshBNS-Crack.lua"))()'},
        {"Cat Hub All In One", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/showscript-hub/Script/refs/heads/main/Cat-hub", true))()'},
        {"Pulse Zax", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua"))()'},
        {"Rene Baterbonia", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg"))()'},
        {"Lkz Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/LucasggkX/LKZ-Hub/refs/heads/main/Loader.lua"))()'},
        {"Miranda Afk", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/afkk"))()'},
        {"Chilli Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()'},
        {"Sodium Hub", 'loadstring(game:HttpGet("https://flowauth.net/v1/loaders/74528f064778ab498a9dde47df0e5206.lua"))()'},
        {"BBM HUB", 'loadstring(game:HttpGet("https://flowauth.net/v1/loaders/044836231e22873544bea7f8f739f7fc.lua"))()'},
        {"Sena Hub", 'loadstring(game:HttpGet("https://senahub.xyz/raw/loader"))()'},
        {"Wzeus Script", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Wzeus-NTH/Wzeusno1/main/Wzeus/nthzz"))()'},
        {"Decode Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzYumi/Decode/refs/heads/main/DE%3ACODE.lua",true))()'},
        {"Fyy Hub", 'loadstring(game:HttpGet("https://FyyCommunity.com"))()'},
        {"Miranda Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealeggies"))()'},
        {"Sources Hub V1", 'loadstring(game:HttpGet("https://pastefy.app/Lk0vDMmN/raw"))()'},
        {"Sources Hub V3", 'loadstring(game:HttpGet("https://api.obscuravm.com/scripts/2007463552086815334"))()'},
        {"Khay Hub V6", 'loadstring(game:HttpGet("https://api.obscuravm.com/scripts/7982111783414007510"))()'},
        {"FOX NAME", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua"))()'},
        {"Chocacola Pet Spawner", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/chocolascript-glitch/Chocola-Pet-Spawner-steal-an-egg/refs/heads/main/script.lua"))()'},
        {"YOKUDU HUB", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/ahchlon/stealanegg/refs/heads/main/Loader.lua"))()'},
        {"Zero Hub All In One", 'loadstring(game:HttpGet("https://gist.githubusercontent.com/CanZero11/ec9b3510734fb65f6a6fff4f6c7ff372/raw/645cece76348dc55197537337317bd072eb07edb/Zero%2520hub.lua"))()'},
        {"Limbo Hub", 'loadstring(game:HttpGet("https://limbohub.my.id/loader.lua"))()'},
        {"Diablo Script", "loadstring(game:HttpGet('https://pastebin.com/raw/f1nDPF4C'))()"},
        {"KALI HUB", "loadstring(game:HttpGet('https://kalihub.xyz/loader.lua'))()"},
        {"Clout Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/ClouthubOnTop/Loader/main/main.lua"))()'},
        {"Zero Point Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/JaxRol/ZeroPoint/refs/heads/main/KeySystem"))()'},
        {"UB HUB", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamUBHub/UBLoader/refs/heads/main/Loader.lua"))()'},
        {"PET AND EGG SPAWNER", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/bugxiefun/roblox-scripts/refs/heads/main/rblxscripts-stealanegg-spawner"))()'},
        {"Blxyo Hub", 'loadstring(game:HttpGet("https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua"))()'},
        {"Toolbox Hub", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Abdullahking20/loader-lua/main/loader"))()'},
        {"Realkid Hub (New)", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua"))()'},
        {"Percy AntiHit", "loadstring(game:HttpGet'https://pastefy.app/lTZUPRyW/raw')()"},
        {"Bee Hub", 'loadstring(game:HttpGet("https://flowauth.net/v1/loaders/026c52c6ec62cd086277f45a113a680a.lua"))()'},
        {"JADENHUB ANTI HIT", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/lalamojaden1/JADEN-HUB/refs/heads/main/ALL%20SCRIPT/Anti_Chase.lua"))()'},
        {"Clover Hub (Key)", 'loadstring(game:HttpGet("https://cloverhub.app/clover.lua"))()'},
        {"Ajjans Hub (Key)", 'loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua"))()'},
        {"Bigfroot Hub (Key)", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()'},
    }
    for _, s in ipairs(list) do MakeRun(ScriptsG, s[1], s[2]) end
end

-- ===== 4 FINDER =====
local FinderG = CreateGroup("Finder")
do
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 22)
    t.BackgroundTransparency = 1
    t.Text = "Server Finder"
    t.TextColor3 = Color3.fromRGB(0, 180, 255)
    t.TextSize = 14
    t.Font = Enum.Font.GothamBold
    t.Parent = FinderG

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.BackgroundTransparency = 1
    status.Text = "Ready"
    status.TextColor3 = Color3.fromRGB(160, 170, 190)
    status.TextSize = 12
    status.Font = Enum.Font.Gotham
    status.Parent = FinderG

    local function makeFind(label, maxP)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.95, 0, 0, 32)
        b.BackgroundColor3 = Color3.fromRGB(0, 90, 180)
        b.Text = label
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 12
        b.Font = Enum.Font.GothamBold
        b.Parent = FinderG
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(function()
            if not requestFunc then status.Text = "No HTTP" return end
            status.Text = "Searching..."
            b.Text = "..."
            task.spawn(function()
                local found, cursor = nil, nil
                for _ = 1, 8 do
                    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                    if cursor then url = url .. "&cursor=" .. tostring(cursor) end
                    local ok, res = pcall(function() return requestFunc({Url = url, Method = "GET"}) end)
                    if ok and res and res.Body then
                        local ok2, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
                        if ok2 and data and data.data then
                            for _, s in ipairs(data.data) do
                                if s.playing and s.playing <= maxP and s.playing < s.maxPlayers then
                                    found = s
                                    break
                                end
                            end
                            cursor = data.nextPageCursor
                            if found or not cursor then break end
                        end
                    end
                    task.wait(0.2)
                end
                if found then
                    status.Text = "Joining " .. found.playing .. " players..."
                    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, found.id, LocalPlayer) end)
                else
                    status.Text = "No server found"
                    b.Text = label
                end
            end)
        end)
    end
    makeFind("Join 1 Player Server", 1)
    makeFind("Join ≤3 Players", 3)
    makeFind("Join ≤5 Players", 5)
    makeFind("Join Any Small Server", 8)
end

-- ===== 5 LIVE CHAT =====
local ChatG = CreateGroup("Chat")
do
    local OWNER = "Chrt2zx"
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 18)
    t.BackgroundTransparency = 1
    t.Text = "Live Chat · Owner: Chrt2zx"
    t.TextColor3 = Color3.fromRGB(0, 180, 255)
    t.TextSize = 12
    t.Font = Enum.Font.GothamBold
    t.Parent = ChatG

    local log = Instance.new("ScrollingFrame")
    log.Size = UDim2.new(1, -4, 0, 170)
    log.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
    log.BorderSizePixel = 0
    log.ScrollBarThickness = 3
    log.Parent = ChatG
    Instance.new("UICorner", log).CornerRadius = UDim.new(0, 8)
    local lay = Instance.new("UIListLayout", log)
    lay.Padding = UDim.new(0, 3)
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        log.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 8)
        log.CanvasPosition = Vector2.new(0, lay.AbsoluteContentSize.Y)
    end)

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.7, 0, 0, 28)
    box.BackgroundColor3 = Color3.fromRGB(28, 30, 42)
    box.PlaceholderText = "Message..."
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 12
    box.Font = Enum.Font.Gotham
    box.Parent = ChatG
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 7)

    local send = Instance.new("TextButton")
    send.Size = UDim2.new(0.28, 0, 0, 28)
    send.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    send.Text = "Send"
    send.TextColor3 = Color3.fromRGB(255, 255, 255)
    send.TextSize = 12
    send.Font = Enum.Font.GothamBold
    send.Parent = ChatG
    Instance.new("UICorner", send).CornerRadius = UDim.new(0, 7)

    local function banner(msg)
        local a = Instance.new("Frame")
        a.Size = UDim2.new(0, 380, 0, 42)
        a.Position = UDim2.new(0.5, -190, 0, 16)
        a.BackgroundColor3 = Color3.fromRGB(0, 70, 160)
        a.BorderSizePixel = 0
        a.Parent = ScreenGui
        Instance.new("UICorner", a).CornerRadius = UDim.new(0, 10)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -10, 1, 0)
        l.Position = UDim2.new(0, 5, 0, 0)
        l.BackgroundTransparency = 1
        l.Text = "OWNER (Chrt2zx): " .. msg
        l.TextColor3 = Color3.fromRGB(255, 255, 255)
        l.TextSize = 13
        l.Font = Enum.Font.GothamBold
        l.TextWrapped = true
        l.Parent = a
        task.delay(4, function() a:Destroy() end)
    end

    local function line(from, msg, isOwner)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, -8, 0, 18)
        l.BackgroundTransparency = 1
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.TextSize = 11
        l.Font = Enum.Font.Gotham
        l.Parent = log
        if isOwner then
            l.Text = "[OWNER] " .. from .. ": " .. msg
            l.TextColor3 = Color3.fromRGB(100, 180, 255)
        else
            l.Text = "[" .. from .. "]: " .. msg
            l.TextColor3 = Color3.fromRGB(200, 210, 230)
        end
    end

    -- Same-server share via ReplicatedStorage (best-effort)
    local folder
    local function getFolder()
        if folder and folder.Parent then return folder end
        local rs = game:GetService("ReplicatedStorage")
        folder = rs:FindFirstChild("ElyxV1Chat")
        if not folder then
            folder = Instance.new("Folder")
            folder.Name = "ElyxV1Chat"
            pcall(function() folder.Parent = rs end)
            if not folder.Parent then
                folder = Instance.new("Folder")
                folder.Name = "ElyxV1ChatLocal"
                folder.Parent = ScreenGui
            end
        end
        return folder
    end

    local seen = {}
    local function onVal(v)
        if not v:IsA("StringValue") or seen[v.Name] then return end
        seen[v.Name] = true
        local from, msg = v.Value:match("^([^|]+)|(.*)$")
        if not from then return end
        local isO = (from == OWNER)
        line(from, msg or "", isO)
        if isO then banner(msg or "") end
    end

    task.spawn(function()
        pcall(function()
            local f = getFolder()
            for _, c in ipairs(f:GetChildren()) do onVal(c) end
            f.ChildAdded:Connect(onVal)
        end)
    end)

    send.MouseButton1Click:Connect(function()
        local text = box.Text
        if text == "" or text:match("^%s*$") then return end
        local isO = (LocalPlayer.Name == OWNER)
        local f = getFolder()
        local id = tostring(os.time()) .. "_" .. LocalPlayer.UserId .. "_" .. math.random(100,999)
        local sv = Instance.new("StringValue")
        sv.Name = id
        sv.Value = LocalPlayer.Name .. "|" .. text
        pcall(function() sv.Parent = f end)
        if not sv.Parent then
            line(LocalPlayer.Name, text, isO)
            if isO then banner(text) end
        end
        box.Text = ""
    end)
end

-- ===== 6 SETTINGS =====
local SettingsG = CreateGroup("Settings")
do
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 22)
    t.BackgroundTransparency = 1
    t.Text = "Settings"
    t.TextColor3 = Color3.fromRGB(0, 180, 255)
    t.TextSize = 14
    t.Font = Enum.Font.GothamBold
    t.Parent = SettingsG

    local blurOn = true
    local b1 = Instance.new("TextButton")
    b1.Size = UDim2.new(0.9, 0, 0, 30)
    b1.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    b1.Text = "Blur: ON"
    b1.TextColor3 = Color3.fromRGB(255, 255, 255)
    b1.TextSize = 12
    b1.Font = Enum.Font.GothamBold
    b1.Parent = SettingsG
    Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 8)
    b1.MouseButton1Click:Connect(function()
        blurOn = not blurOn
        if blur then blur.Size = blurOn and 14 or 0 end
        b1.Text = blurOn and "Blur: ON" or "Blur: OFF"
    end)

    local b2 = Instance.new("TextButton")
    b2.Size = UDim2.new(0.9, 0, 0, 30)
    b2.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    b2.Text = "Destroy Hub"
    b2.TextColor3 = Color3.fromRGB(255, 150, 150)
    b2.TextSize = 12
    b2.Font = Enum.Font.GothamBold
    b2.Parent = SettingsG
    Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 8)
    b2.MouseButton1Click:Connect(function()
        if blur then blur:Destroy() end
        ScreenGui:Destroy()
    end)

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 50)
    info.BackgroundTransparency = 1
    info.Text = "Elyx Hub V1 All Scripts\nOwner chat: Chrt2zx\nSources Hub scripts included"
    info.TextColor3 = Color3.fromRGB(140, 150, 170)
    info.TextSize = 11
    info.Font = Enum.Font.Gotham
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.Parent = SettingsG
end

-- Drag
local function Drag(frame)
    local dragging, start, pos
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true; start = i.Position; pos = frame.Position
        end
    end)
    frame.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - start
            frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
        end
    end)
end
Drag(Main)
Drag(HideBtn)

Switch("Profile")

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Elyx Hub V1",
        Text = "All Scripts loaded",
        Duration = 4,
    })
end)

print("[Elyx Hub V1] All Scripts ready")
