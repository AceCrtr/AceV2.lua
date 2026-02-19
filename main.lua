local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local cg = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")
local pps = game:GetService("ProximityPromptService")
local cam = workspace.CurrentCamera

local spd = 250
local tpDist = 50
local auraMenzil = 30
local hizliKosmaGucu = 100 
local states = {fly = false, noclip = false, hitbox = false, aura = false, infJump = false, speed = false, fastE = false, open = true}
local bv

local pm = require(p:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local cm = pm:GetControls()

local guiName = "AceV2Gui"
local targetFolder = gethui and gethui() or (pcall(function() return cg.Name end) and cg or p:WaitForChild("PlayerGui"))
if targetFolder:FindFirstChild(guiName) then targetFolder[guiName]:Destroy() end

local sg = Instance.new("ScreenGui", targetFolder)
sg.Name = guiName
sg.ResetOnSpawn = false 

----------------------------------------------------------------
-- ANA MENÜ (BAŞLANGIÇTA GİZLİ)
----------------------------------------------------------------
local mf = Instance.new("Frame", sg)
mf.Size, mf.Position, mf.BackgroundColor3, mf.BorderSizePixel = UDim2.new(0, 310, 0, 285), UDim2.new(0.5, -155, 0.08, 0), Color3.fromRGB(20, 20, 25), 0
mf.Active = false 
mf.Visible = false 
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 12)

local mStroke = Instance.new("UIStroke", mf)
mStroke.Color, mStroke.Thickness, mStroke.ApplyStrokeMode = Color3.fromRGB(255, 85, 85), 2, Enum.ApplyStrokeMode.Border

local tl = Instance.new("TextLabel", mf)
tl.Size, tl.Position, tl.Text, tl.BackgroundTransparency, tl.TextColor3, tl.Font, tl.TextSize = UDim2.new(1, 0, 0, 35), UDim2.new(0, 0, 0, 0), "⚡ ACE V2 ⚡", 1, Color3.new(1, 1, 1), Enum.Font.GothamBlack, 18

local btnContainer = Instance.new("Frame", mf)
btnContainer.Size, btnContainer.Position, btnContainer.BackgroundTransparency = UDim2.new(1, -20, 1, -45), UDim2.new(0, 10, 0, 35), 1
btnContainer.Active = false

local grid = Instance.new("UIGridLayout", btnContainer)
grid.CellSize, grid.CellPadding, grid.SortOrder = UDim2.new(0, 140, 0, 35), UDim2.new(0, 10, 0, 10), Enum.SortOrder.LayoutOrder

local tb = Instance.new("TextButton", sg)
tb.Size, tb.Position, tb.BackgroundColor3, tb.Text, tb.TextColor3, tb.Font, tb.TextSize = UDim2.new(0, 45, 0, 45), UDim2.new(0.5, -22, 0.02, 0), Color3.fromRGB(255, 85, 85), "X", Color3.new(1, 1, 1), Enum.Font.GothamBold, 16
tb.Visible = false 
Instance.new("UICorner", tb).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", tb)
tStroke.Color, tStroke.Thickness = Color3.fromRGB(255, 255, 255), 2

tb.MouseButton1Click:Connect(function()
    states.open = not states.open
    mf.Visible = states.open
    tb.Text = states.open and "X" or "ACE"
    tb.BackgroundColor3 = states.open and Color3.fromRGB(255, 85, 85) or Color3.fromRGB(40, 200, 40)
end)

----------------------------------------------------------------
-- KEY SİSTEMİ EKRANI
----------------------------------------------------------------
local keyFrame = Instance.new("Frame", sg)
keyFrame.Size = UDim2.new(0, 260, 0, 140)
keyFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)
local kStroke = Instance.new("UIStroke", keyFrame)
kStroke.Color, kStroke.Thickness = Color3.fromRGB(255, 85, 85), 2

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.Text = "ACE V2 - GİRİŞ"
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1, 1, 1)
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 16

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.PlaceholderText = "Key Girin..."
keyBox.Font = Enum.Font.GothamSemibold
keyBox.TextSize = 14
keyBox.Text = ""
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 6)

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.8, 0, 0, 35)
keyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
keyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 40)
keyBtn.Text = "GİRİŞ YAP"
keyBtn.TextColor3 = Color3.new(1, 1, 1)
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "AceKilloki" then
        keyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        keyBtn.Text = "BAŞARILI!"
        task.wait(0.5)
        keyFrame:Destroy() 
        mf.Visible = true 
        tb.Visible = true 
    else
        local oldColor = keyBox.BackgroundColor3
        keyBox.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        keyBox.Text = ""
        keyBox.PlaceholderText = "YANLIŞ KEY!"
        task.wait(1)
        keyBox.BackgroundColor3 = oldColor
        keyBox.PlaceholderText = "Key Girin..."
    end
end)

----------------------------------------------------------------
-- HİLE SİSTEMLERİ VE MANTIĞI
----------------------------------------------------------------
local drag, dragStart, startPos
mf.InputBegan:Connect(function(i)
    if i.UserInputType.Name:match("MouseButton1") or i.UserInputType.Name:match("Touch") then
        drag, dragStart, startPos = true, i.Position, mf.Position
        i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then drag = false end end)
    end
end)
uis.InputChanged:Connect(function(i)
    if drag and (i.UserInputType.Name:match("MouseMovement") or i.UserInputType.Name:match("Touch")) then
        local d = i.Position - dragStart
        mf.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

local function upBtn(b, st, isim)
    if st then
        b.BackgroundColor3 = Color3.fromRGB(30, 160, 40)
        b.Text = "🟢 " .. isim .. " [AÇIK]"
        b.UIStroke.Color = Color3.fromRGB(0, 255, 0)
    else
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        b.Text = "🔴 " .. isim .. " [KAPALI]"
        b.UIStroke.Color = Color3.fromRGB(255, 80, 80)
    end
end

local function mkBtn(isim, ord)
    local b = Instance.new("TextButton", btnContainer)
    b.Font, b.TextSize, b.TextColor3, b.LayoutOrder = Enum.Font.GothamBold, 12, Color3.new(1, 1, 1), ord
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local bs = Instance.new("UIStroke", b)
    bs.Thickness, bs.ApplyStrokeMode = 1, Enum.ApplyStrokeMode.Border
    upBtn(b, false, isim) 
    return b
end

local function toggleFly(st)
    states.fly = st
    local c = p.Character
    if c and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChildOfClass("Humanoid") then
        c.Humanoid.PlatformStand = st
        if st then
            bv = Instance.new("BodyVelocity", c.HumanoidRootPart)
            bv.MaxForce, bv.Velocity, bv.Name = Vector3.new(math.huge, math.huge, math.huge), Vector3.zero, "FlyV"
        elseif c.HumanoidRootPart:FindFirstChild("FlyV") then
            c.HumanoidRootPart.FlyV:Destroy()
        end
    end
end

rs.RenderStepped:Connect(function()
    if states.fly and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        local mv = cm:GetMoveVector()
        local dir = mv.Magnitude > 0 and cam.CFrame:VectorToWorldSpace(mv).Unit or Vector3.zero
        if bv and bv.Parent then bv.Velocity = dir * spd end
    end
end)

local function toggleNoclip(st)
    states.noclip = st
    if not st and p.Character then
        for _, v in pairs(p.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = true end end
    end
end

local function toggleHitbox(st)
    states.hitbox = st
    if not st then
        for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
            if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                pl.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end

local function toggleSpeed(st)
    states.speed = st
    if p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
        p.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = st and hizliKosmaGucu or 16
    end
end

local function toggleFastE(st)
    states.fastE = st
    if st then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
    end
end

pps.PromptShown:Connect(function(prompt)
    if states.fastE then prompt.HoldDuration = 0 end
end)

uis.JumpRequest:Connect(function()
    if states.infJump and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
        p.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

rs.Stepped:Connect(function()
    if states.noclip and p.Character then
        for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end end
    end
    if states.hitbox then
        for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
            if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15)
                pl.Character.HumanoidRootPart.Transparency = 1 
                pl.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
    if states.aura and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        local tool = p.Character:FindFirstChildOfClass("Tool")
        if tool then
            local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
            for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
                if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Character:FindFirstChild("Humanoid") then
                    if pl.Character.Humanoid.Health > 0 then
                        local dist = (pl.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                        if dist <= auraMenzil then
                            tool:Activate() 
                            if firetouchinterest and handle then
                                firetouchinterest(handle, pl.Character.HumanoidRootPart, 0)
                                firetouchinterest(handle, pl.Character.HumanoidRootPart, 1)
                            end
                        end
                    end
                end
            end
        end
    end
    if states.speed and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
        p.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = hizliKosmaGucu
    end
end)

-- BUTON BAĞLANTILARI
local fBtn = mkBtn("FLY", 1)
fBtn.MouseButton1Click:Connect(function() toggleFly(not states.fly) upBtn(fBtn, states.fly, "FLY") end)

local nBtn = mkBtn("NOCLIP", 2)
nBtn.MouseButton1Click:Connect(function() toggleNoclip(not states.noclip) upBtn(nBtn, states.noclip, "NOCLIP") end)

local hBtn = mkBtn("HITBOX", 3)
hBtn.MouseButton1Click:Connect(function() toggleHitbox(not states.hitbox) upBtn(hBtn, states.hitbox, "HITBOX") end)

local aBtn = mkBtn("AURA", 4)
aBtn.MouseButton1Click:Connect(function() states.aura = not states.aura; upBtn(aBtn, states.aura, "AURA") end)

local jBtn = mkBtn("INF JUMP", 5)
jBtn.MouseButton1Click:Connect(function() states.infJump = not states.infJump; upBtn(jBtn, states.infJump, "INF JUMP") end)

local sBtn = mkBtn("SPEED", 6)
sBtn.MouseButton1Click:Connect(function() toggleSpeed(not states.speed) upBtn(sBtn, states.speed, "SPEED") end)

local feBtn = mkBtn("FAST E", 7)
feBtn.MouseButton1Click:Connect(function() toggleFastE(not states.fastE) upBtn(feBtn, states.fastE, "FAST E") end)

-- YAKIN TP BUTONU
local cTpBtn = Instance.new("TextButton", btnContainer)
cTpBtn.Font, cTpBtn.TextSize, cTpBtn.TextColor3, cTpBtn.LayoutOrder = Enum.Font.GothamBold, 12, Color3.new(1, 1, 1), 8
cTpBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 200) 
cTpBtn.Text = "🎯 YAKIN TP"
Instance.new("UICorner", cTpBtn).CornerRadius = UDim.new(0, 6)
local cTpStroke = Instance.new("UIStroke", cTpBtn)
cTpStroke.Color, cTpStroke.Thickness, cTpStroke.ApplyStrokeMode = Color3.fromRGB(200, 100, 255), 1, Enum.ApplyStrokeMode.Border

cTpBtn.MouseButton1Click:Connect(function()
    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return end
    local closestPlayer, shortestDistance, myPos = nil, math.huge, p.Character.HumanoidRootPart.Position
    for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
        if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (pl.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist < shortestDistance then shortestDistance, closestPlayer = dist, pl end
        end
    end
    if closestPlayer then p.Character.HumanoidRootPart.CFrame = closestPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0) end
    cTpBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    task.wait(0.1)
    cTpBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 200)
end)

-- İLERİ TP BUTONU
local tpBtn = Instance.new("TextButton", btnContainer)
tpBtn.Font, tpBtn.TextSize, tpBtn.TextColor3, tpBtn.LayoutOrder = Enum.Font.GothamBold, 12, Color3.new(1, 1, 1), 9
tpBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 200)
tpBtn.Text = "⏩ İLERİ TP"
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
local tpStroke = Instance.new("UIStroke", tpBtn)
tpStroke.Color, tpStroke.Thickness, tpStroke.ApplyStrokeMode = Color3.fromRGB(100, 150, 255), 1, Enum.ApplyStrokeMode.Border

tpBtn.MouseButton1Click:Connect(function()
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        p.Character.HumanoidRootPart.CFrame += p.Character.HumanoidRootPart.CFrame.LookVector * tpDist
    end
    tpBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    task.wait(0.1)
    tpBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 200)
end)

-- YENİ: FPS BOOST BUTONU
local fpsBtn = Instance.new("TextButton", btnContainer)
fpsBtn.Font, fpsBtn.TextSize, fpsBtn.TextColor3, fpsBtn.LayoutOrder = Enum.Font.GothamBold, 12, Color3.new(1, 1, 1), 10
fpsBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 40) -- Turuncu renk
fpsBtn.Text = "🚀 FPS BOOST"
Instance.new("UICorner", fpsBtn).CornerRadius = UDim.new(0, 6)
local fpsStroke = Instance.new("UIStroke", fpsBtn)
fpsStroke.Color, fpsStroke.Thickness, fpsStroke.ApplyStrokeMode = Color3.fromRGB(255, 150, 50), 1, Enum.ApplyStrokeMode.Border

fpsBtn.MouseButton1Click:Connect(function()
    local l = game:GetService("Lighting")
    local t = workspace:FindFirstChildOfClass("Terrain")
    
    l.GlobalShadows = false
    for _, v in pairs(l:GetDescendants()) do
        if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
    end
    if t then
        t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance, t.WaterTransparency = 0, 0, 0, 0
    end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    
    fpsBtn.Text = "✅ BOOSTLANDI"
    fpsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    fpsStroke.Color = Color3.fromRGB(50, 50, 50)
end)

p.CharacterAdded:Connect(function() 
    if states.fly then toggleFly(true) end 
    if states.speed then toggleSpeed(true) end
end)
