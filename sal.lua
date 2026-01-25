--////////////////////////////////////////////////////////
--             Criminality Full Script - Fixed Teleport Farm
--////////////////////////////////////////////////////////

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

-- Создаем интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CriminalityFarm"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true  -- Сразу видим
mainFrame.Active = true
mainFrame.Parent = screenGui

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 18
titleBar.Text = "Criminality Farm (K - show/hide)"
titleBar.Parent = mainFrame

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -10, 1, -40)
contentFrame.Position = UDim2.new(0, 5, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 6
contentFrame.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = contentFrame

-- Перетаскивание
local dragging = false
local dragOffset = Vector2.new()

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragOffset = input.Position - mainFrame.AbsolutePosition
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        mainFrame.Position = UDim2.new(0, input.Position.X - dragOffset.X, 0, input.Position.Y - dragOffset.Y)
    end
end)

-- ФИКС: Привязка к клавише K с проверкой на фокус ввода
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Проверяем, не обрабатывается ли уже ввод игрой
    if gameProcessed then return end
    
    -- Проверяем, находится ли фокус в текстовом поле
    local focusedTextBox = UserInputService:GetFocusedTextBox()
    if focusedTextBox then
        -- Если фокус в текстовом поле, пропускаем обработку K
        return
    end
    
    if input.KeyCode == Enum.KeyCode.K then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Загрузка внешних скриптов
local IYLoaded = false
local CriminalityLoaded = false
local AntiAFKLoaded = false

local function LoadInfiniteYield()
    if not IYLoaded then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        IYLoaded = true
        return true
    end
    return true
end

local function LoadCriminalityScript()
    if not CriminalityLoaded then
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/LisSploit/FemboysHubBoosr/2784d6c4ede4340ad9af4865828d915ffc26c7bb/Criminality"))()
        end)
        if success then
            CriminalityLoaded = true
            return true
        else
            warn("Failed to load Criminality Script:", err)
            return false
        end
    end
    return true
end

local function LoadAntiAFK()
    if not AntiAFKLoaded then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))()
        AntiAFKLoaded = true
        return true
    end
    return true
end

-- Save позиции (поменяны Void и Darkness местами)
local SavePositions = {
    Cube = Vector3.new(-4184.4, 102.7, 276.9),
    Vibecheck = Vector3.new(-4857.5, -161.5, -918.3),
    Mountain = Vector3.new(-5169.8, 102.6, -515.5),
    Void = Vector3.new(-5071, -259, -301),     -- Теперь Darkness позиция
    RCU = Vector3.new(-4375, 97, 233),
    Darkness = Vector3.new(-5121, -283, 1440)  -- Теперь Void позиция
}

-- Активные соединения
local ActiveConnections = {}

local function StopConnection(name)
    if ActiveConnections[name] then
        ActiveConnections[name]:Disconnect()
        ActiveConnections[name] = nil
    end
end

local function StopAllConnections()
    for name, connection in pairs(ActiveConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    ActiveConnections = {}
end

-- Admin Check
local AdminList = {
    ["hisupermario9"] = true, ["ARRYvvv"] = true, ["Nex5us"] = true,
    ["stbh"] = true, ["misterzapata"] = true, ["Avelosky"] = true,
    ["Aphache_Pilot"] = true, ["largomorph"] = true, ["Cand1ebox"] = true,
    ["Prixza"] = true, ["Kalivarian"] = true, ["Vixxage"] = true,
    ["ThumbThwack"] = true, ["isaac3523"] = true, ["king_ab09"] = true,
    ["therealscotlad"] = true, ["Omnidens"] = true, ["eastonjaps"] = true,
    ["SheriffGorji"] = true, ["Cefasin"] = true, ["simwastakenlol"] = true,
    ["Knightak"] = true, ["kaijumaiju"] = true, ["rainjeremy"] = true,
    ["jake_jpeg"] = true, ["karateeeh"] = true, ["Aitareis"] = true,
    ["xXFireyScorpionXx"] = true, ["fausties"] = true, ["KeenlyAware"] = true,
    ["vnzu"] = true, ["personhacks1"] = true, ["Dalvanuis"] = true,
    ["UncrossedMeat3888"] = true, ["IAmUnderAMask"] = true, ["icarus_xs1goliath"] = true,
    ["parachuter2000"] = true, ["mrzued"] = true, ["JayyMlg"] = true,
    ["woomyware"] = true, ["Saabor"] = true, ["Razuatix"] = true,
    ["Mr68Moth"] = true, ["codedcosmetics"] = true, ["TDXiswinning"] = true,
    ["FelixVenue"] = true, ["SIEGFRlED"] = true, ["GalacticSculptor"] = true,
    ["FractalHarmonics"] = true, ["QuantumCaterpillar"] = true, ["AerelisVA"] = true,
    ["harht"] = true, ["oTheSilver"] = true, ["CRIMCORP"] = true,
    ["ionCantCode"] = true, ["velskopio"] = true, ["Rekalu"] = true,
    ["DeliverCreations"] = true, ["Strivian"] = true, ["z_papermoon"] = true,
    ["RlFLEM4N"] = true, ["TZZV"] = true, ["Castlers"] = true,
    ["r3shape"] = true, ["ZZZXIIIXZZZ"] = true, ["RVVZ"] = true,
    ["BruhmanVIII"] = true
}

local AdminCheckEnabled = false
local AdminCheckConnection

local function StartAdminCheck()
    local function CheckAdmins()
        for _, plr in ipairs(Players:GetPlayers()) do
            if AdminList[plr.Name] then
                LocalPlayer:Kick("Admin Detected")
                task.wait(2)
                game:Shutdown()
                return
            end
        end
    end
    
    CheckAdmins()
    
    AdminCheckConnection = Players.PlayerAdded:Connect(function(plr)
        if AdminList[plr.Name] then
            LocalPlayer:Kick("Admin Detected")
            task.wait(2)
            game:Shutdown()
        end
    end)
    
    ActiveConnections["AdminCheck"] = RunService.Heartbeat:Connect(function()
        CheckAdmins()
    end)
    
    return true
end

local function StopAdminCheck()
    if AdminCheckConnection then
        AdminCheckConnection:Disconnect()
    end
    StopConnection("AdminCheck")
    return false
end

-- Save позиции
local function StartSave(positionName)
    local position = SavePositions[positionName]
    local deathEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DeathRespawn")
    
    StopConnection("Save_" .. positionName)
    
    ActiveConnections["Save_" .. positionName] = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if rootPart then
                rootPart.CFrame = CFrame.new(position)
            end
            
            if humanoid and humanoid.Health <= 0 then
                deathEvent:InvokeServer("KMG4R904")
            end
        end
    end)
    
    return true
end

local function StopSave(positionName)
    StopConnection("Save_" .. positionName)
    return false
end

-- Fly функция
local FlyEnabled = false
local FlyConnection

local function StartFly()
    FlyEnabled = true
    
    StopConnection("Fly")
    
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not FlyEnabled then return end
        
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end

        if moveDir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (moveDir.Unit * 2)
        end
    end)
    
    ActiveConnections["Fly"] = FlyConnection
    return true
end

local function StopFly()
    FlyEnabled = false
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    StopConnection("Fly")
    return false
end

-- Noclip
local function StartNoclip()
    StopConnection("Noclip")
    
    ActiveConnections["Noclip"] = RunService.Stepped:Connect(function()
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    return true
end

local function StopNoclip()
    StopConnection("Noclip")
    return false
end

-- Melee Aura (только атака, без телепортации)
local MeleeAuraEnabled = false
local MeleeAuraConnection

local function StartMeleeAura()
    MeleeAuraEnabled = true
    
    local plrs = game:GetService("Players")
    local remote1 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH.2")
    local remote2 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH2.2")
    
    local function Attack(target)
        if not (target and target:FindFirstChild("Head")) then return end
        
        local arg1 = {
            [1] = "🍞", [2] = tick(), [3] = LocalPlayer.Character:FindFirstChildOfClass("Tool"),
            [4] = "43TRFWX", [5] = "Normal", [6] = tick(), [7] = true
        }
        local result = remote1:InvokeServer(unpack(arg1))
        task.wait(0.1)

        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            local Handle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle") or LocalPlayer.Character:FindFirstChild("Right Arm")
            if Handle and target:FindFirstChild("Head") then
                local arg2 = {
                    [1] = "🍞", [2] = tick(), [3] = tool, [4] = "2389ZFX34", [5] = result,
                    [6] = false, [7] = Handle, [8] = target:FindFirstChild("Head"), [9] = target,
                    [10] = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position,
                    [11] = target:FindFirstChild("Head").Position
                }
                remote2:FireServer(unpack(arg2))
            end
        end
    end

    StopConnection("MeleeAura")
    
    ActiveConnections["MeleeAura"] = RunService.Heartbeat:Connect(function()
        if not MeleeAuraEnabled then return end
        
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, plr in ipairs(plrs:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local c = plr.Character
                    local hrp2 = c and c:FindFirstChild("HumanoidRootPart")
                    local hum = c and c:FindFirstChildOfClass("Humanoid")
                    if hrp2 and hum then
                        local dist = (hrp.Position - hrp2.Position).Magnitude
                        if dist < 10 and hum.Health > 15 and not c:FindFirstChildOfClass("ForceField") then
                            Attack(c)
                        end
                    end
                end
            end
        end
    end)
    
    return true
end

local function StopMeleeAura()
    MeleeAuraEnabled = false
    StopConnection("MeleeAura")
    return false
end

-- Teleport Farm как в твоем скрипте
local TPFarm_Enabled = false
local TPFarm_TargetName = "Maddiekittycatcat"

local TPFarm_SteppedConnection = nil
local TPFarm_RenderConnection = nil
local TPFarm_CharConnection = nil
local DeathRespawn_Event = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DeathRespawn")

local function TPFarm_OnCharacterAdded(char)
    if TPFarm_SteppedConnection then
        TPFarm_SteppedConnection:Disconnect()
        TPFarm_SteppedConnection = nil
    end

    task.wait(1)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end

    TPFarm_SteppedConnection = RunService.Stepped:Connect(function()
        if not TPFarm_Enabled then return end
        local mainPlayer = Players:FindFirstChild(TPFarm_TargetName)
        local mainChar = mainPlayer and mainPlayer.Character
        local mainHRP = mainChar and mainChar:FindFirstChild("HumanoidRootPart")
        if mainHRP then
            hrp.CFrame = mainHRP.CFrame + (mainHRP.CFrame.LookVector * 3)

            hum:GetPropertyChangedSignal("Health"):Connect(function()
                hum.Health = 0
            end)
        end
    end)
end

local function TPFarm_Enable()
    if TPFarm_Enabled then return end
    TPFarm_Enabled = true

    local me = LocalPlayer

    if me.Character then
        TPFarm_OnCharacterAdded(me.Character)
    end

    TPFarm_CharConnection = me.CharacterAdded:Connect(function(newChar)
        if not TPFarm_Enabled then return end
        TPFarm_OnCharacterAdded(newChar)

        local tool = me.Backpack:FindFirstChildOfClass("Tool")
        if tool and newChar then
            tool.Parent = newChar
        end
    end)

    TPFarm_RenderConnection = RunService.RenderStepped:Connect(function()
        if not TPFarm_Enabled then return end
        local char = me.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health <= 0 then
                wait(0.3)
                DeathRespawn_Event:InvokeServer("KMG4R904")
                wait(0.3)
            end
        end
    end)
end

local function TPFarm_Disable()
    if not TPFarm_Enabled then return end
    TPFarm_Enabled = false

    if TPFarm_SteppedConnection then
        TPFarm_SteppedConnection:Disconnect()
        TPFarm_SteppedConnection = nil
    end
    if TPFarm_RenderConnection then
        TPFarm_RenderConnection:Disconnect()
        TPFarm_RenderConnection = nil
    end
    if TPFarm_CharConnection then
        TPFarm_CharConnection:Disconnect()
        TPFarm_CharConnection = nil
    end
end

-- Deleted Mob
local DeletedMobRan = false

local function RunDeletedMob()
    if not DeletedMobRan then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mick-gordon/Hyper-Escape/main/DeleteMobV2.lua", true))()
        DeletedMobRan = true
        return true
    end
    return true
end

-- Создание кнопок
local ActiveFunctions = {}

local function CreateToggleButton(text, startFunc, stopFunc)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = contentFrame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 1
    button.BorderColor3 = Color3.fromRGB(80, 80, 80)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = 14
    button.Parent = frame
    
    ActiveFunctions[text] = false
    
    button.MouseButton1Click:Connect(function()
        if ActiveFunctions[text] then
            stopFunc()
            ActiveFunctions[text] = false
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            button.Text = text
        else
            startFunc()
            ActiveFunctions[text] = true
            button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
            button.Text = text .. " [ON]"
        end
    end)
    
    return frame
end

local function CreateActionButton(text, actionFunc)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = contentFrame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    button.BorderSizePixel = 1
    button.BorderColor3 = Color3.fromRGB(80, 80, 80)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = 14
    button.Parent = frame
    
    button.MouseButton1Click:Connect(function()
        local success = actionFunc()
        if success == false then
            button.Text = text .. " ❌"
        else
            button.Text = text .. " ✓"
        end
        task.wait(1)
        button.Text = text
    end)
    
    return frame
end

local function CreateTPFarmRow()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.BackgroundTransparency = 1
    frame.Parent = contentFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Teleport Farm Target:"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 25)
    textBox.Position = UDim2.new(0, 0, 0, 20)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Text = TPFarm_TargetName
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 14
    textBox.Parent = frame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 25)
    button.Position = UDim2.new(0, 0, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 1
    button.BorderColor3 = Color3.fromRGB(80, 80, 80)
    button.Text = "Teleport Farm"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = 14
    button.Parent = frame
    
    textBox.FocusLost:Connect(function()
        TPFarm_TargetName = textBox.Text
    end)
    
    local TPFarmActive = false
    
    button.MouseButton1Click:Connect(function()
        if TPFarmActive then
            TPFarm_Disable()
            TPFarmActive = false
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            button.Text = "Teleport Farm"
        else
            TPFarm_Enable()
            TPFarmActive = true
            button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
            button.Text = "Teleport Farm [ON]"
        end
    end)
    
    return frame
end

-- Создаем кнопки
CreateActionButton("Infinite Yield", LoadInfiniteYield)
CreateActionButton("Criminality Script", LoadCriminalityScript)
CreateActionButton("Anti-AFK", LoadAntiAFK)
CreateActionButton("Deleted Mob", RunDeletedMob)

CreateToggleButton("Admin Check", StartAdminCheck, StopAdminCheck)
CreateToggleButton("Fly", StartFly, StopFly)
CreateToggleButton("Noclip", StartNoclip, StopNoclip)
CreateToggleButton("Melee Aura", StartMeleeAura, StopMeleeAura)

-- Teleport Farm с полем ввода (исправленная версия)
CreateTPFarmRow()

-- Кнопки сохранения позиций (теперь с поменянными Void и Darkness)
for saveName, _ in pairs(SavePositions) do
    CreateToggleButton("Save " .. saveName, 
        function() return StartSave(saveName) end,
        function() return StopSave(saveName) end
    )
end

-- Кнопка остановки всего
local stopFrame = Instance.new("Frame")
stopFrame.Size = UDim2.new(1, 0, 0, 30)
stopFrame.BackgroundTransparency = 1
stopFrame.Parent = contentFrame

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(1, 0, 1, 0)
stopButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
stopButton.BorderSizePixel = 1
stopButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
stopButton.Text = "STOP ALL"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.TextSize = 14
stopButton.Parent = stopFrame

stopButton.MouseButton1Click:Connect(function()
    StopAllConnections()
    for text, _ in pairs(ActiveFunctions) do
        ActiveFunctions[text] = false
    end
    
    -- Сбрасываем все кнопки
    for _, btn in pairs(contentFrame:GetChildren()) do
        if btn:IsA("Frame") then
            local otherButton = btn:FindFirstChildOfClass("TextButton")
            if otherButton then
                otherButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                otherButton.Text = otherButton.Text:gsub(" %[ON%]", "")
                if otherButton.BackgroundColor3 == Color3.fromRGB(0, 100, 200) then
                    otherButton.Text = otherButton.Text:gsub(" ✓", "")
                    otherButton.Text = otherButton.Text:gsub(" ❌", "")
                end
            end
        end
    end
    
    stopButton.Text = "ALL STOPPED ✓"
    task.wait(1)
    stopButton.Text = "STOP ALL"
end)

-- Автоматически запускаем функции при инжекте
task.spawn(function()
    task.wait(2)

    -- Admin Check
    StartAdminCheck()
    ActiveFunctions["Admin Check"] = true

    -- Auto-enable Teleport Farm
    TPFarm_Enable()

    -- Auto-enable Save Cube
    StartSave("Cube")
    ActiveFunctions["Save Cube"] = true

    -- Auto-enable Melee Aura
    StartMeleeAura()
    ActiveFunctions["Melee Aura"] = true

    -- Update UI buttons
    for _, btn in pairs(contentFrame:GetChildren()) do
        if btn:IsA("Frame") then
            local button = btn:FindFirstChildOfClass("TextButton")
            if button then
                if button.Text == "Admin Check" then
                    button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                    button.Text = "Admin Check [ON]"
                end
                if button.Text == "Save Cube" then
                    button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                    button.Text = "Save Cube [ON]"
                end
                if button.Text == "Teleport Farm" then
                    button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                    button.Text = "Teleport Farm [ON]"
                end
                if button.Text == "Melee Aura" then
                    button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                    button.Text = "Melee Aura [ON]"
                end
            end
        end
    end

    print("Criminality Script loaded! Admin Check, TP Farm, Save Cube, and Melee Aura enabled.")
end)




-- Конец скрипта





