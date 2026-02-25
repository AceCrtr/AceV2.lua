local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local cg = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")
local pps = game:GetService("ProximityPromptService")
local cam = workspace.CurrentCamera

----------------------------------------------------------------
-- ⚠️ DİKKAT: AŞAĞIDAKİ İKİ LİNKİ KENDİ LİNKLERİNLE DEĞİŞTİR! ⚠️
local keysLink = "https://raw.githubusercontent.com/AceCrtr/AceV2.lua/refs/heads/main/keys.txt"
local webhookLink = "https://discord.com/api/webhooks/1476166591342444554/WNNYQG_0cEC8MvRjSc5z7Hu2gUcy6BEHt-FCLbFRmnog-Ra9r_cGbRehTyRQnHvA6wXM"
----------------------------------------------------------------

local spd = 250
local auraMenzil = 30
local states = {fly = false, noclip = false, hitbox = false, aura = false, infJump = false, fastE = false, autoCollect = false, open = true}
local bv

local pm = require(p:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local cm = pm:GetControls()

local guiName = "AceV2PremiumGui"
local targetFolder = gethui and gethui() or (pcall(function() return cg.Name end) and cg or p:WaitForChild("PlayerGui"))
if targetFolder:FindFirstChild(guiName) then targetFolder[guiName]:Destroy() end

local sg = Instance.new("ScreenGui", targetFolder)
sg.Name = guiName
sg.ResetOnSpawn = false 

-- RENK PALETİ
local bgKoyu = Color3.fromRGB(15, 15, 18)
local bgAcik = Color3.fromRGB(25, 25, 30)
local goldRenk = Color3.fromRGB(255, 215, 0)
local beyazText = Color3.new(1, 1, 1)
local siyahText = Color3.new(0, 0, 0)

-- ANA MENÜ
local mf = Instance.new("Frame", sg)
mf.Size, mf.Position, mf.BackgroundColor3, mf.BorderSizePixel = UDim2.new(0, 320, 0, 270), UDim2.new(0.5, -160, 0.08, 0), bgKoyu, 0
mf.Active = false 
mf.Visible = false 
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 10)

local mStroke = Instance.new("UIStroke", mf)
mStroke.Color, mStroke.Thickness, mStroke.ApplyStrokeMode = goldRenk, 2, Enum.ApplyStrokeMode.Border

local tl = Instance.new("TextLabel", mf)
tl.Size, tl.Position, tl.Text, tl.BackgroundTransparency, tl.TextColor3, tl.Font, tl.TextSize = UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 0), "👑 ACE V2 PREMIUM+ 👑", 1, goldRenk, Enum.Font.GothamBlack, 18

local line = Instance.new("Frame", mf)
line.Size, line.Position, line.BackgroundColor3, line.BorderSizePixel = UDim2.new(0.9, 0, 0, 1), UDim2.new(0.05, 0, 0, 40), goldRenk, 0

local btnContainer = Instance.new("Frame", mf)
btnContainer.Size, btnContainer.Position, btnContainer.BackgroundTransparency = UDim2.new(1, -20, 1, -55), UDim2.new(0, 10, 0, 48), 1
btnContainer.Active = false

local grid = Instance.new("UIGridLayout", btnContainer)
grid.CellSize, grid.CellPadding, grid.SortOrder = UDim2.new(0, 145, 0, 36), UDim2.new(0, 10, 0, 12), Enum.SortOrder.LayoutOrder

-- AÇ/KAPA BUTONU
local tb = Instance.new("TextButton", sg)
tb.Size, tb.Position, tb.BackgroundColor3, tb.Text, tb.TextColor3, tb.Font, tb.TextSize = UDim2.new(0, 45, 0, 45), UDim2.new(0.5, -22, 0.02, 0), goldRenk, "X", siyahText, Enum.Font.GothamBlack, 18
tb.Visible = false 
Instance.new("UICorner", tb).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", tb)
tStroke.Color, tStroke.Thickness = beyazText, 2

tb.MouseButton1Click:Connect(function()
    states.open = not states.open
    mf.Visible = states.open
    tb.Text = states.open and "X" or "ACE"
    tb.BackgroundColor3 = states.open and goldRenk or bgAcik
    tb.TextColor3 = states.open and siyahText or goldRenk
end)

-- KEY SİSTEMİ EKRANI
local keyFrame = Instance.new("Frame", sg)
keyFrame.Size = UDim2.new(0, 280, 0, 150)
keyFrame.Position = UDim2.new(0.5, -140, 0.4, 0)
keyFrame.BackgroundColor3 = bgKoyu
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)
local kStroke = Instance.new("UIStroke", keyFrame)
kStroke.Color, kStroke.Thickness = goldRenk, 2

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.Text = "💎 PREMIUM GİRİŞ"
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = goldRenk
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 16

local keyLine = Instance.new("Frame", keyFrame)
keyLine.Size, keyLine.Position, keyLine.BackgroundColor3, keyLine.BorderSizePixel = UDim2.new(0.8, 0, 0, 1), UDim2.new(0.1, 0, 0, 38), goldRenk, 0

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
keyBox.BackgroundColor3 = bgAcik
keyBox.TextColor3 = beyazText
keyBox.PlaceholderText = "Premium Key Girin..."
keyBox.Font = Enum.Font.GothamSemibold
keyBox.TextSize = 14
keyBox.Text = ""
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 6)

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.8, 0, 0, 35)
keyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
keyBtn.BackgroundColor3 = goldRenk
keyBtn.Text = "GİRİŞ YAP"
keyBtn.TextColor3 = siyahText
keyBtn.Font = Enum.Font.GothamBlack
keyBtn.TextSize = 14
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

local function showKeyError(msg)
    local oldColor = keyBox.BackgroundColor3
    keyBox.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    keyBox.Text = ""
    keyBox.PlaceholderText = msg
    task.wait(1.5)
    keyBox.BackgroundColor3 = oldColor
    keyBox.PlaceholderText = "Premium Key Girin..."
    keyBtn.Text = "GİRİŞ YAP"
end

-- DISCORD WEBHOOK GÖNDERME FONKSİYONU
local function sendWebhookLog(usedKey)
    if webhookLink == "" or not string.match(webhookLink, "discord") then return end
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🚀 ACE V2 PREMIUM+ | YENİ GİRİŞ!",
            ["description"] = "**👤 Oyuncu:** `" .. p.Name .. "`\n**🔑 Kullanılan Key:** `" .. usedKey .. "`\n**🎮 Oyun ID:** `" .. game.PlaceId .. "`",
            ["color"] = tonumber(0xFFD700) 
        }}
    }
    
    local jsonData = game:GetService("HttpService"):JSONEncode(data)
    local requestFunc = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    
    if requestFunc then
        pcall(function()
            requestFunc({
                Url = webhookLink,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
    end
end

-- SÜRE VE KİŞİ KONTROLLÜ GITHUB SİSTEMİ
keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "" then return end
    keyBtn.Text = "KONTROL EDİLİYOR..."
    
    local success, keysData = pcall(function() return game:HttpGet(keysLink) end)

    if success then
        local found = false
        local errorMsg = "GEÇERSİZ KEY!"
        
        for line in string.gmatch(keysData, "[^\r\n]+") do
            local parts = string.split(line, "|")
            local k_pass = parts[1]
            local k_user = parts[2]
            local k_date = parts[3]

            if keyBox.Text == k_pass then
                found = true
                
                if k_user and k_user ~= "ALL" and p.Name ~= k_user then
                    found = false
                    errorMsg = "BU KEY BAŞKASINA AİT!"
                    break
                end

                if k_date and k_date ~= "SINIRSIZ" then
                    local y, m, d = string.match(k_date, "(%d+)-(%d+)-(%d+)")
                    if y and m and d then
                        local expireTime = os.time({year=y, month=m, day=d})
                        if os.time() > expireTime then
                            found = false
                            errorMsg = "KEY SÜRESİ DOLMUŞ!"
                            break
                        end
                    end
                end
                break 
            end
        end

        if found then
            keyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            keyBtn.Text = "ERİŞİM ONAYLANDI"
            
            -- GİRİŞ BAŞARILIYSA DISCORD'A MESAJ GÖNDER
            task.spawn(function()
                sendWebhookLog(keyBox.Text)
            end)

            task.wait(0.5)
            keyFrame:Destroy() 
            mf.Visible = true 
            tb.Visible = true 
        else
            showKeyError(errorMsg)
        end
    else
        keyBtn.Text = "BAĞLANTI HATASI!"
        task.wait(1)
        keyBtn.Text = "GİRİŞ YAP"
    end
end)

-- SÜRÜKLEME
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
        b.BackgroundColor3 = goldRenk
        b.Text = isim .. " [ON]"
        b.TextColor3 = siyahText
        b.UIStroke.Color = goldRenk
    else
        b.BackgroundColor3 = bgAcik
        b.Text = isim .. " [OFF]"
        b.TextColor3 = beyazText
        b.UIStroke.Color = Color3.fromRGB(60, 60, 65)
    end
end

local function mkBtn(isim, ord)
    local b = Instance.new("TextButton", btnContainer)
    b.Font, b.TextSize, b.LayoutOrder = Enum.Font.GothamBold, 12, ord
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local bs = Instance.new("UIStroke", b)
    bs.Thickness, bs.ApplyStrokeMode = 1, Enum.ApplyStrokeMode.Border
    upBtn(b, false, isim) 
    return b
end

-- STANDART HİLELER
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

local function toggleFastE(st)
    states.fastE = st
    if st then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
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

-- AUTO COLLECT
task.spawn(function()
    while task.wait(0.5) do
        if states.autoCollect and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") then
                    local part = v.Parent
                    if part and part:IsA("BasePart") then
                        if firetouchinterest then
                            firetouchinterest(p.Character.HumanoidRootPart, part, 0)
                            firetouchinterest(p.Character.HumanoidRootPart, part, 1)
                        end
                    end
                end
            end
        end
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
end)

-- BUTONLARI OLUŞTURMA
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

local feBtn = mkBtn("FAST E", 6)
feBtn.MouseButton1Click:Connect(function() toggleFastE(not states.fastE) upBtn(feBtn, states.fastE, "FAST E") end)

local acBtn = mkBtn("AUTO COLLECT", 7)
acBtn.MouseButton1Click:Connect(function() states.autoCollect = not states.autoCollect; upBtn(acBtn, states.autoCollect, "AUTO COLLECT") end)

local fpsBtn = Instance.new("TextButton", btnContainer)
fpsBtn.Font, fpsBtn.TextSize, fpsBtn.TextColor3, fpsBtn.LayoutOrder = Enum.Font.GothamBold, 12, beyazText, 8
fpsBtn.BackgroundColor3 = bgAcik 
fpsBtn.Text = "🚀 FPS BOOST"
Instance.new("UICorner", fpsBtn).CornerRadius = UDim.new(0, 6)
local fpsStroke = Instance.new("UIStroke", fpsBtn)
fpsStroke.Color, fpsStroke.Thickness = Color3.fromRGB(100, 100, 100), 1

fpsBtn.MouseButton1Click:Connect(function()
    local l = game:GetService("Lighting")
    local t = workspace:FindFirstChildOfClass("Terrain")
    l.GlobalShadows = false
    for _, v in pairs(l:GetDescendants()) do
        if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
    end
    if t then t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance, t.WaterTransparency = 0, 0, 0, 0 end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
    fpsBtn.Text = "✅ BOOSTLANDI"
    fpsBtn.BackgroundColor3 = goldRenk
    fpsBtn.TextColor3 = siyahText
    fpsStroke.Color = goldRenk
end)

p.CharacterAdded:Connect(function() 
    if states.fly then toggleFly(true) end 
end)

