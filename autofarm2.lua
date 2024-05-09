-- Table
_G.configuration = {
    status = true,
    optimize = true, -- decreases gpu/mem usage
    disablerendering = false, -- decreases gpu usage
    screengui = true, -- screen gui that covers entire screen with information such as the amount of cash along with a combat indicator
    behavior = {
        pickupdelay = 0.86, -- pickupdelay to prevent kick
        furtherpickupdelay = 0.14, -- pickupdelay + furtherpickupdelay for further cash to prevent kick
        hospitalfarm = true, -- automatically completes hospital when idle
        shoefarm = true, -- automatically collects shoes when idle
        autobox = true, -- automatically boxes before farming
        fpscapacity = 3, -- decreases cpu usage (lower = less usage / higher = more usage)
    },
    purchases = {
        mask = true, -- automatically purchases and equips masks
        unjail = true, -- automatically purchases and uses key to unjail
    },
    serverhop = {
        leaveonknock = true, -- automatically serverhops when knocked
        timer = {
            usetimer = true, -- automatically serverhops after 'seconds' passes
            seconds = 180
        },
        playerjoinedhop = false, -- automatically serverhops when player with matching id in 'joinedids' joins
        joinedids = {

        },
        playerexistshop = true, -- automatically serverhops when player with matching id in 'existsids' already is in the server
        existsids = {
            4839199587,
            4839208183,
            4839211426,
            4841225793,
            4841230996,
            4852051938,
            4852053779,
            4852055386,
            4852057398,
            4852059395,
            --prestigedhc1-10 above
            3628439595,
            --progarillamadmnar
            5618935183,
            5619846786,
            5617789196,
            5622048532,
            5622778798,
            5624616890,
            5619456987,
            5617631602,
            5618201686,
            5618587708,
            5621718427,
            5621771483,
            5716489376,
            5717577116,
            5617446506,
            5622534302,
            5618057388,
            5623859356,
            5617820291,
            5618345097,
            5327703090,
            5327703217,
            5327703208,
            5327703556,
            5327703640,
            5327703735,
            5327704066,
            5663930616,
            5538815339,
            3718045446,
            3718041567,
            3718039351,
            3718037805,
            3718031255,
            3718028682,
            3718019947,
            5327702870,
            5538357489,
            3717988286,
            3718046979,
            3718049045,
            3718058329,
            3718061120,
            3719084596,
            3717990516,
            3719087676,
            3719088792,
            3719091389,
            3719094992,
            3719095974,
            3717992314,
            3717994572,
            3718013439,
            502075313,
            5327703158,
        },
    }
}
--\\ no skid or study :'(












-- Script
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:WaitForChild('FULLY_LOADED_CHAR')

-- Services
local players = game:GetService('Players')
local httpservice = game:GetService('HttpService')
local lighting = game:GetService('Lighting')
local coregui = game:GetService('CoreGui')
local teleportservice = game:GetService('TeleportService')
local runservice = game:GetService('RunService')
local virtualuser = game:GetService('VirtualUser')

-- Instances
local localplayer = game.Players.LocalPlayer
local datafolder = localplayer:WaitForChild('DataFolder')
local information = datafolder:WaitForChild('Information')

local register = workspace.Cashiers
local ignored = workspace.Ignored
local hospital = ignored.HospitalJob
local drop = ignored.Drop
local shop = ignored.Shop

-- Set Frame Capacity
setfpscap(_G.configuration.behavior.fpscapacity)

-- Mute Game Audio
UserSettings().GameSettings.MasterVolume = 0

-- Anti Afk
localplayer.Idled:Connect(function()
    virtualuser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    virtualuser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- Functions
local function getbutton(name)
    for _, child in ipairs(shop:GetChildren()) do
        if string.match(child.Name, name) and child:FindFirstChild('Head') then
            return child
        end
    end
end

local function serverhop()
    local placeid = game.PlaceId
    local servers = httpservice:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/'.. placeid.. '/servers/Public?sortOrder=Asc&limit=100'))
    local openservers = {}
    for _, v in pairs(servers.data) do
        if v.playing ~= v.maxPlayers and v.playerIds ~= localplayer.UserId then
            table.insert(openservers, v)
        end
    end

    teleportservice:TeleportToPlaceInstance(placeid, openservers[math.random(1, #openservers)].id)
end

local function optimize()
    pcall(function()
    local ignoreinstances = {'Camera', 'Terrain', 'Cashiers', 'Ignored', 'Players'}
    for _, child in ipairs(workspace:GetChildren()) do
        if not table.find(ignoreinstances, child.Name) then
            pcall(function()
                if child.Name == 'MAP' then
                    for _, child in ipairs(child:GetChildren()) do
                        if child.Name ~= 'Map' then
                            child:Destroy()
                        else
                            for _, child in ipairs(child:GetChildren()) do
                                if child.Name ~= 'Punching(BAGS)' then
                                    child:Destroy()
                                end
                            end
                        end
                    end
                else
                    child:Destroy()
                end
            end)
        end
    end

    local ignoreinstances = {'Siren', 'Drop', 'Shop', 'Clean the shoes on the floor and come to me for cash', 'HospitalJob'}
    for _, child in ipairs(workspace.Ignored:GetChildren()) do
        if not table.find(ignoreinstances, child.Name) then
            child:Destroy()
        end
    end
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Astonlix/LuaU/Da-Hood/A.lua'))()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Astonlix/LuaU/Da-Hood/B.lua'))()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/ultra-optimize.lua'))()
end)
end

-- Reset Fix
localplayer.Character.Humanoid.Health = 0

-- Optimization
if _G.configuration.optimize then
    optimize()
end

-- 3D Rendering
if _G.configuration.disablerendering then
    runservice:Set3dRenderingEnabled(false)
end

-- Screengui
if _G.configuration.screengui then
    task.spawn(function()
        local screengui = Instance.new('ScreenGui')
        screengui.Name = '/QuickCash'
        screengui.IgnoreGuiInset = true
        screengui.Parent = game:GetService('CoreGui')

        local frame = Instance.new('Frame')
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.Parent = screengui

        local cashtext = Instance.new('TextLabel')
        cashtext.BackgroundTransparency = 1
        cashtext.AnchorPoint = Vector2.new(0.5, 0.5)
        cashtext.Size = UDim2.new(0.5, 0, 0.5, 0)
        cashtext.Position = UDim2.new(0.5, 0, 0.5, 0)
        cashtext.TextScaled = true
        cashtext.Parent = frame

        local discordtext = Instance.new('TextLabel')
        discordtext.BackgroundTransparency = 1
        discordtext.AnchorPoint = Vector2.new(0.5, 0.5)
        discordtext.Size = UDim2.new(0.1, 0, 0.1, 0)
        discordtext.Position = UDim2.new(0.5, 0, 0.6, 0)
        discordtext.TextScaled = true
        discordtext.Text = 'discord.gg/QuickCash'
        discordtext.Parent = frame

        local hascombat = Instance.new('TextLabel')
        hascombat.BackgroundTransparency = 1
        hascombat.AnchorPoint = Vector2.new(0.5, 0.5)
        hascombat.Size = UDim2.new(0.1, 0, 0.1, 0)
        hascombat.Position = UDim2.new(0.5, 0, 0.4, 0)
        hascombat.TextScaled = true
        hascombat.Text = 'Has Combat : Nil'
        hascombat.Parent = frame

        while _G.configuration.status and task.wait() do
            pcall(function()
                cashtext.Text = localplayer:WaitForChild('PlayerGui'):WaitForChild('MainScreenGui'):WaitForChild('MoneyText').Text
            end)

            pcall(function()
                if localplayer.Backpack:FindFirstChild('Combat') or localplayer.Character:FindFirstChild('Combat') then
                    hascombat.Text = 'Has Combat:TRUE'
                else
                    hascombat.Text = 'Has Combat:FALSE'
                end
            end)
        end
    end)
end

-- Serverhopping
if _G.configuration.serverhop.playerexistshop then
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localplayer and table.find(_G.configuration.serverhop.existsids, player.UserId) then
            serverhop()
        end
    end
end

if _G.configuration.serverhop.playerjoinedhop then
    players.PlayerAdded:Connect(function(player)
        if player ~= localplayer and table.find(_G.configuration.serverhop.joinedids, player.UserId) then
            serverhop()
        end
    end)
end

if _G.configuration.serverhop.timer.usetimer then
    task.delay(_G.configuration.serverhop.timer.seconds, function()
        serverhop()
    end)
end

-- Rejoin
game:GetService('CoreGui').RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild('ErrorFrame') then
        serverhop()
    end
end)

-- Auto Box
pcall(function()
    if _G.configuration.behavior.autobox then
        if not information:FindFirstChild('BoxingValue') then
            -- Get Boxing Value
            local punchingbag = CFrame.new(-251.834228515625, 24.212146759033203, -1138.8836669921875)
            repeat
                task.wait()

                localplayer.Character.HumanoidRootPart.CFrame = punchingbag
                localplayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                if localplayer.Backpack:FindFirstChild('Combat') then
                    localplayer.Character.Humanoid:EquipTool(localplayer.Backpack.Combat)
                else
                    localplayer.Character:FindFirstChild('Combat'):Activate()
                    localplayer.Character:FindFirstChild('Combat'):Deactivate()
                end
            until information:FindFirstChild('BoxingValue')
        end

        if tonumber(information:FindFirstChild('BoxingValue').Value) < 2500 then
            -- Increase Boxing Value
            local punchingbag = CFrame.new(-251.834228515625, 24.212146759033203, -1138.8836669921875)
            repeat
                task.wait()

                localplayer.Character.HumanoidRootPart.CFrame = punchingbag
                localplayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                if localplayer.Backpack:FindFirstChild('Combat') then
                    localplayer.Character.Humanoid:EquipTool(localplayer.Backpack.Combat)
                else
                    localplayer.Character:FindFirstChild('Combat'):Activate()
                    localplayer.Character:FindFirstChild('Combat'):Deactivate()
                end
            until tonumber(information:FindFirstChild('BoxingValue').Value) >= 2500
        end

        if not information:FindFirstChild('FightingStyle') then
            local button = workspace.Ignored.Shop['[Default Moveset] - $0']
            repeat
                task.wait()

                localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(button.Head.Position - Vector3.new(0, 10, 0))
                localplayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                if fireclickdetector then
                    -- Function Exists
                    fireclickdetector(button.ClickDetector)
                else   
                    localplayer:Kick('Executor Does Not Support fireclickdetector')
                end
            until information:FindFirstChild('FightingStyle')
        end

        if tonumber(information:FindFirstChild('BoxingValue').Value) >= 2500 then
            local button = workspace.Ignored.Shop['Boxing Moveset (Require: Max Box Stat) - $0']
            repeat
                task.wait()

                localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(button.Head.Position - Vector3.new(0, 10, 0))
                localplayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                if fireclickdetector then
                    -- Function Exists
                    fireclickdetector(button.ClickDetector)
                else   
                    localplayer:Kick('Executor Does Not Support fireclickdetector')
                end
            until information:FindFirstChild('FightingStyle').Value ~= 'Default'
        end

        localplayer.Character.Humanoid:UnequipTools()
    end
end)

-- Reset Fix
if localplayer.Character then
    localplayer.Character.Humanoid.Health = 0
end
task.spawn(function()
    for Index, Value in pairs(game:GetService('CoreGui'):GetChildren()) do
        if Value.Name == '/QuickCash' then continue end
        
        Value:Destroy()
    end
end)
-- Farm
localplayer.CharacterAdded:Connect(function(character)
    -- Wait For Load
    character:WaitForChild('HumanoidRootPart')
    repeat
        task.wait()

        character.HumanoidRootPart.CFrame = CFrame.new(0, -250, 0)
        character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    until character:FindFirstChild('FULLY_LOADED_CHAR') or _G.configuration.status == false

    -- AutoMask
    if _G.configuration.purchases.mask then
        local timer = tick()
        local button = getbutton('Surgeon Mask')
        repeat
            task.wait()
    
            character.HumanoidRootPart.CFrame = button.Head.CFrame * CFrame.new(0, -10, 0)
            character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            if tick() - timer >= 0.5 then
                fireclickdetector(button.ClickDetector)
            end
        until localplayer.Backpack:FindFirstChild('[Mask]') or _G.configuration.status == false
    
        repeat
            task.wait()
    
            character.HumanoidRootPart.CFrame = button.Head.CFrame * CFrame.new(0, -10, 0)
            character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    
            character.Humanoid:EquipTool(localplayer.Backpack:FindFirstChild('[Mask]'))
        until character:FindFirstChild('[Mask]') or _G.configuration.status == false
    
        if character:FindFirstChild('[Mask]') then
            character:FindFirstChild('[Mask]'):Activate()
        end
    end

    -- Unjail
    if _G.configuration.purchases.unjail and character.BodyEffects.Cuff.Value == true then
        local timer = tick()
        local button = getbutton('Key')
        repeat
            task.wait()
    
            character.HumanoidRootPart.CFrame = button.Head.CFrame * CFrame.new(0, -10, 0)
            character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            if tick() - timer >= 0.5 then
                fireclickdetector(button.ClickDetector)
            end
        until localplayer.Backpack:FindFirstChild('[Key]') or _G.configuration.status == false
    
        repeat
            task.wait()
    
            character.HumanoidRootPart.CFrame = button.Head.CFrame * CFrame.new(0, -10, 0)
            character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    
            if localplayer.Backpack:FindFirstChild('[Key]') then
                character.Humanoid:EquipTool(localplayer.Backpack:FindFirstChild('[Key]'))
            end
        until character:FindFirstChild('[Key]') or _G.configuration.status == false
    end

    repeat
        task.wait()

        pcall(function()
            local currentregister = nil
            for _, register in ipairs(register:GetChildren()) do
                if register.Humanoid.Health > 0 then
                    currentregister = register
                end
            end

            if currentregister then
                -- Register
                repeat
                    task.wait()

                    if character.BodyEffects.Attacking.Value == true then
                        if (Vector3.new(-624.5984497070312, 22.850021362304688, -286.6582336425781) - currentregister.Open.Position).Magnitude <= 2 then
                            character.HumanoidRootPart.CFrame = currentregister.Open.CFrame * CFrame.new(-3, 0, 0)
                        elseif (Vector3.new(-627.5984497070312, 22.850021362304688, -286.6581726074219) - currentregister.Open.Position).Magnitude <= 2 then
                            character.HumanoidRootPart.CFrame = currentregister.Open.CFrame * CFrame.new(3, 0, 0)
                        else
                            character.HumanoidRootPart.CFrame = currentregister.Open.CFrame
                        end
                    else
                        character.HumanoidRootPart.CFrame = currentregister.Open.CFrame * CFrame.new(0, -8, 0)
                    end

                    if localplayer.Backpack:FindFirstChild('Combat') then
                        character.Humanoid:EquipTool(localplayer.Backpack.Combat)
                    else
                        if character:FindFirstChild('Combat') then
                            character.Combat:Activate()
                        elseif not localplayer.Backpack:FindFirstChild('Combat') and not character:FindFirstChild('Combat') then
                            serverhop()
                        end
                    end

                    if _G.configuration.serverhop.leaveonknock then
                        if character.BodyEffects['K.O'].Value == true then
                            serverhop()
                        end
                    end

                    character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                until currentregister.Humanoid.Health <= 0 or _G.configuration.status == false

                character.Humanoid:UnequipTools()

                for _, child in ipairs(drop:GetChildren()) do
                    if child.Name == 'MoneyDrop' then
                        if (character.HumanoidRootPart.Position - child.Position).Magnitude <= 11 then
                            local timer = tick()
                            local timeout = tick()
                            repeat
                                task.wait()

                                if tick() - timer >= _G.configuration.behavior.pickupdelay and child:FindFirstChild('ClickDetector') then
                                    fireclickdetector(child.ClickDetector)
                                    timer = tick()
                                end

                                character.HumanoidRootPart.CFrame = CFrame.new(child.Position - Vector3.new(0, 10, 0))
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            until tick() - timeout >= 5 or not child:FindFirstChild('ClickDetector') or child.Parent == nil or _G.configuration.status == false
                        elseif (character.HumanoidRootPart.Position - child.Position).Magnitude <= 25 then
                            local timer = tick()
                            local timeout = tick()
                            repeat
                                task.wait()

                                if tick() - timer >= _G.configuration.behavior.pickupdelay + _G.configuration.behavior.furtherpickupdelay and child:FindFirstChild('ClickDetector') then
                                    fireclickdetector(child.ClickDetector)
                                    timer = tick()
                                end

                                character.HumanoidRootPart.CFrame = CFrame.new(child.Position - Vector3.new(0, 10, 0))
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            until tick() - timeout >= 5 or not child:FindFirstChild('ClickDetector') or child.Parent == nil or _G.configuration.status == false
                        end
                    end
                end
            else
                -- Idle
                character.HumanoidRootPart.CFrame = CFrame.new(0, -250, 0)
                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                -- Leave On Knock
                if _G.configuration.serverhop.leaveonknock then
                    if character.BodyEffects['K.O'].Value == true then
                        serverhop()
                    end
                end

                -- Shoe Farm
                if _G.configuration.behavior.shoefarm then
                    for _, child in ipairs(drop:GetChildren()) do
                        if child.Name ~= 'MoneyDrop' then
                            local timer = tick()
                            repeat
                                task.wait()
                    
                                character.HumanoidRootPart.CFrame = CFrame.new(child.Position - Vector3.new(0, 10, 0))
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    
                                if child:FindFirstChild('ClickDetector') then
                                    fireclickdetector(child.ClickDetector)
                                end
                            until tick() - timer >= 1 or child.Parent == nil or not child:FindFirstChild('ClickDetector') or _G.configuration.status == false
                    
                            if character.BodyEffects.ShoesCollect.Value >= 1 then
                                repeat
                                    task.wait()
                    
                                    character.HumanoidRootPart.CFrame = CFrame.new(ignored["Clean the shoes on the floor and come to me for cash"].HumanoidRootPart.Position - Vector3.new(0, 10, 0))
                                    character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    
                                    fireclickdetector(ignored["Clean the shoes on the floor and come to me for cash"].ClickDetector)
                                until character.BodyEffects.ShoesCollect.Value <= 0 or _G.configuration.status == false
                            end
                        end
                    end                
                end

                -- Hospital Farm
                if _G.configuration.behavior.hospitalfarm then
                    local npc = hospital:FindFirstChildOfClass('Model')

                    local timeout = tick()
                    if npc and npc.Name ~= 'Thank you!' then
                        if string.match(npc.Name, 'Red') then
                            repeat
                                task.wait()

                                character.HumanoidRootPart.CFrame = CFrame.new(hospital.Red.Position - Vector3.new(0, 12, 0))
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                                fireclickdetector(hospital.Red:FindFirstChild('ClickDetector'))
                            until tick() - timeout >= 1 or character.BodyEffects.HospitalJob.Value == 'Red' or _G.configuration.status == false
                        elseif string.match(npc.Name, 'Blue') then
                            repeat
                                task.wait()

                                character.HumanoidRootPart.CFrame = CFrame.new(hospital.Blue.Position - Vector3.new(0, 12, 0))
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                                fireclickdetector(hospital.Red:FindFirstChild('ClickDetector'))
                            until tick() - timeout >= 1 or character.BodyEffects.HospitalJob.Value == 'Blue' or _G.configuration.status == false
                        elseif string.match(npc.Name, 'Green') then
                            repeat
                                task.wait()

                                character.HumanoidRootPart.CFrame = CFrame.new(hospital.Green.Position - Vector3.new(0, 12, 0))
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                                fireclickdetector(hospital.Red:FindFirstChild('ClickDetector'))
                            until tick() - timeout >= 1 or character.BodyEffects.HospitalJob.Value == 'Green' or _G.configuration.status == false
                        end

                        local timeout = tick()
                        repeat
                            task.wait()

                            character.HumanoidRootPart.CFrame = CFrame.new(npc.HumanoidRootPart.Position - Vector3.new(0, 10, 0))
                            character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                            fireclickdetector(npc:FindFirstChild('ClickDetector'))
                        until tick() - timeout >= 1 or npc.Parent == nil or npc.Name == 'Thank you!' or _G.configuration.status == false
                    end
                end
            end
        end)
    until _G.configuration.status == false
end)

task.spawn(function()
    for Index, Value in pairs(game:GetService('CoreGui'):GetChildren()) do
        if Value.Name == '/QuickCash' then continue end

        Value:Destroy()
    end
end)
