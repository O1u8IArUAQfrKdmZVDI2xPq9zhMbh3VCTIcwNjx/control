local mode = loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/mode.lua'))()

if mode == 0 then
  return print('no')
elseif mode == 1 then
  print("hello world")
elseif mode == 2 then
  print('ac')
elseif mode == 4 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/autofarm'))()
elseif mode == 5 then
local Settings = {
	['Auto Mask'] = false,
	['Auto Unjail'] = true,
    ['Server Hop'] = true,
    ['FPS'] = 3,
    ['Codes'] = {
        'TRADEME!',
        'DAUP',
        'MELONBEAR',
        'HALLOWEEN2023',
        'pumpkins2023',
        'RUBY',
    }
}

setfflag("TaskSchedulerTargetFps", tostring(Settings.FPS))

-- \\ Services
local Player = game:GetService('Players');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
--\\ Variables
local Client = Player.LocalPlayer
local Backpack = Client.Backpack
local ShopFolder = game.Workspace.Ignored.Shop

for Index, Value in pairs(Settings.Codes) do
    ReplicatedStorage.MainEvent:FireServer("EnterPromoCode", Value)
    task.wait(2)
end

loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/ultra-optimize.lua'))()


--> auto rejoin
getgenv().Rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
	if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
		game:GetService("TeleportService"):Teleport(game.PlaceId)
	end
end)

--> optimizing
for _, v in ipairs(game.Workspace.Cashiers:GetChildren()) do
	local open_part = v.Open

	local floor = Instance.new("Part")
	floor.Size = Vector3.new(100, 1, 100)
	floor.Position = open_part.Position - Vector3.new(0, 4.7, 0)
	floor.Anchored = true
	floor.Parent = workspace
end

pcall(function()
	workspace.MAP:Destroy()
	workspace.Lights:Destroy()

	for _, v in ipairs(game.Lighting:GetChildren()) do
		v:Destroy()
	end
end)

--> functions
local function check_loaded()
	if local_player and local_player.Backpack and local_player.Backpack:FindFirstChild("Combat") and local_player.Character and local_player.Character:FindFirstChild("FULLY_LOADED_CHAR") then
		return true
	end

	return false
end

local function get_register(return_child)
	register_count = 0
	for _, register in ipairs(workspace.Cashiers:GetChildren()) do
		if register.Humanoid.Health > 0 then
			register_count = register_count + 1
			if return_child then
				return register
			end
		end
	end

	return register_count
end

local function check_combat()
	if check_loaded() and Backpack:FindFirstChild("Combat") then
		Client.Character.Humanoid:EquipTool(Client.Backpack:FindFirstChild("Combat"))
	end 
end

local function get_button(name)
	for _, button in ipairs(ShopFolder:GetChildren()) do
		if button.Name:match(name) then
			return button
		end
	end

	return warn("Autofarm Error: Failed To Find '"..name.."' Button")
end

while getgenv().toggle and task.wait() do
	pcall(function()
        for _,plr in ipairs(Player:GetPlayers()) do
            if plr.Name:sub(1,8) == 'Prestige' then
                -- serverhop
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
        
                local _place = game.PlaceId
                local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                local function ListServers(cursor)
                local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                return Http:JSONDecode(Raw)
            end
        
                local Server, Next; 
                repeat
                    local Servers = ListServers(Next)
                    Server = Servers.data[1]
                    Next = Servers.nextPageCursor
                until Server
        
                TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
            end
        end
		-- check if player has loaded, and local player exists, and if character exists
		if check_loaded() then
            repeat
                -- get atm
                local atm = get_register(true)
                local angle = 0

                if atm then
                    -- establish new localplayer, character
                    local players = game.Players
                    local localplayer = players.LocalPlayer
                    local character = localplayer.Character or localplayer.CharacterAdded:Wait()

                    -- punch register
                    repeat
                        task.wait()

                        angle = angle + 1

                        -- check bodyeffects
                        if character.BodyEffects.Attacking.Value == true then
                            -- attacking hit register
                            character.HumanoidRootPart.CFrame = atm.Open.CFrame * CFrame.Angles(0, math.rad(angle), 0)
                            character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        else
                            -- not attacking charge attack
                            repeat
                                task.wait()

                                -- check backpack
                                if character.BodyEffects.Dead.Value then
                                    -- make sure tools are removed to prevent breaking
                                    if character:FindFirstChildOfClass("Tool") then
                                        -- remove tools
                                        character.Humanoid:UnequipTools()
                                    end
                                else
                                    if localplayer.Backpack:FindFirstChild("Combat") then
                                        -- equip
                                        character.Humanoid:EquipTool(localplayer.Backpack:FindFirstChild("Combat"))
                                    else
                                        -- in hand
                                        character:FindFirstChild("Combat"):Activate()
                                    end
                                end

                                character.HumanoidRootPart.CFrame = atm.Open.CFrame * CFrame.new(0, -10, 0)
                                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            until character:FindFirstChildOfClass("Highlight") or character.BodyEffects.Dead.Value
                        end
                    until atm.Humanoid.Health <= 0 or character.BodyEffects.Dead.Value

                    -- atm broke, collect cash
                    pcall(function()
                        for _, cash in ipairs(workspace.Ignored.Drop:GetChildren()) do
                            if cash.Name == "MoneyDrop" and (character.HumanoidRootPart.Position - cash.Position).Magnitude <= 25 then
                                local delay = tick()
                                repeat
                                    task.wait()

                                    if tick() - delay <= 0.86 and cash:FindFirstChild("ClickDetector") then
                                        fireclickdetector(cash.ClickDetector)
                                    end

                                    character.HumanoidRootPart.CFrame = CFrame.new(cash.Position - Vector3.new(0, 8, 0))
                                    character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                                until cash.Parent == nil
                            end
                        end

                        -- auto mask checking
                        if Settings['Auto Mask'] and not Client.Character:FindFirstChild("In-gameMask") then
                            pcall(function()
                                -- establish new localplayer, character
                                local players = game.Players
                                local localplayer = players.LocalPlayer
                                local character = localplayer.Character or localplayer.CharacterAdded:Wait()

                                local button = get_button("Surgeon Mask")
                                repeat
                                    task.wait()

                                    character:FindFirstChild("HumanoidRootPart").CFrame = button.Head.CFrame * CFrame.new(0, -5, 0)
                                    character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)

                                    fireclickdetector(button.ClickDetector)
                                until localplayer.Backpack:FindFirstChild("[Mask]")

                                local mask = localplayer.Backpack:WaitForChild("[Mask]")
                                character.Humanoid:EquipTool(mask)
                                mask:Activate()
                            end)
                        end

                        -- jail checking
                        if Settings['Auto Unjail'] and Client.Character.BodyEffects.Cuff.Value == true then
                            -- is jailed
                            pcall(function()
                                -- establish new localplayer, character
                                local players = game.Players
                                local localplayer = players.LocalPlayer
                                local character = localplayer.Character or localplayer.CharacterAdded:Wait()

                                local button = get_button("Key")
                                repeat
                                    task.wait()

                                    character:WaitForChild("HumanoidRootPart").CFrame = button.Head.CFrame * CFrame.new(0, -5, 0)
                                    character:WaitForChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)

                                    fireclickdetector(button.ClickDetector)
                                until localplayer.Backpack:FindFirstChild("[Key]")

                                local key = localplayer.Backpack:WaitForChild("[Key]")
                                character.Humanoid:EquipTool(key)
                            end)
                        end
                    end)
                else
                    if Settings['Server Hop'] then
                        local Http = game:GetService("HttpService")
                        local TPS = game:GetService("TeleportService")
                        local Api = "https://games.roblox.com/v1/games/"

                        local _place = game.PlaceId
                        local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                        local function ListServers(cursor)
                            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                            return Http:JSONDecode(Raw)
                        end
                                
                        local Server, Next; 
                        repeat
                            local Servers = ListServers(Next)
                            Server = Servers.data[1]
                            Next = Servers.nextPageCursor
                        until Server
                        TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
                    else
                        -- establish new localplayer, character
                        local players = game.Players
                        local localplayer = players.LocalPlayer
                        local character = localplayer.Character or localplayer.CharacterAdded:Wait()

                        character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
                        character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            until getgenv().toggle == false
		end
	end)
end


loadstring(game:HttpGet('https://raw.githubusercontent.com/Astonlix/LuaU/Da-Hood/A.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Astonlix/LuaU/Da-Hood/B.lua'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/ultra-optimize.lua'))()
game:GetService("RunService"):Set3dRenderingEnabled(true)
end
