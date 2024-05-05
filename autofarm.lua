local Settings = {
    Enabled = false,
    Codes = {
        'TRADEME!',
        'DAUP',
        'MELONBEAR',
        'HALLOWEEN2023',
        'pumpkins2023',
        'RUBY',
    }
}
Settings.Enabled = not Settings.Enabled

-- \\ Services
local Players = game:GetService('Players');
local RunService = game:GetService('RunService');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- \\ Variables
local Client = Players.LocalPlayer;
local ShopFolder = game.Workspace.Ignored.Shop;

local function CheckLoaded()
    if (Client and Client.Character and Client.Character:FindFirstChild("FULLY_LOADED_CHAR") and Client.Backpack and Client.Backpack:FindFirstChild("Combat")) then
		return true
	end

	return false
end

local function GetRegister(Child)
	RegisterCount = 0
	for Index, Value in pairs(workspace.Cashiers:GetChildren()) do
		if (Value.Humanoid.Health > 0) then
			RegisterCount += 1
            
            if (Child) then
                return Value
            end
		end
	end

	return RegisterCount
end

local function GetButton(Name)
	for _, button in ipairs(ShopFolder:GetChildren()) do
		if button.Name:match(Name) then
			return button
		end
	end

	return warn("Autofarm Error: Failed To Find '"..Name.."' Button")
end

local function Serverhop()
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
    
    TPS:TeleportToPlaceInstance(_place,Server.id, Client)
end

task.spawn(function()
    for Index, Value in pairs(Settings.Codes) do
        ReplicatedStorage.MainEvent:FireServer("EnterPromoCode", Value)
        task.wait(3)
    end
end)

repeat task.wait()
    local _, Error = pcall(function()
        if (CheckLoaded()) then
            --[[for Index, Value in ipairs(Players:GetPlayers()) do
                if (not Value.Name:sub(1,8) == 'Prestige') then continue end

                Serverhop()
            end]]
            if (Settings.AutoUnjail and Client.Character.BodyEffects.Cuff.Value == true) then
                pcall(function()

                    local button = GetButton("Key")
                    repeat
                        task.wait()

                        Client.Character:WaitForChild("HumanoidRootPart").CFrame = button.Head.CFrame * CFrame.new(0, -5, 0)
                        Client.Character:WaitForChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0)

                        fireclickdetector(button.ClickDetector)
                    until Client.Backpack:FindFirstChild("[Key]") or not Settings.Enabled

                    local key = Client.Backpack:WaitForChild("[Key]")
                    Client.Character.Humanoid:EquipTool(key)
                end)
            end
            if Client.Character.Humanoid.Health < 100 then
                Serverhop()
            end
            local ATM = GetRegister(true)
            local Angle = 0
            
            if (ATM) then
                repeat task.wait()
                    Angle += 1

                    if (Client.Character.BodyEffects.Attacking.Value == true) then
                        Client.Character.HumanoidRootPart.CFrame = ATM.Open.CFrame * CFrame.Angles(0, math.rad(Angle), 0)
                        Client.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    else
                        repeat task.wait()
                            if (Client.Backpack.BodyEffects.Dead.Value) then
                                if (Client.Character:FindFirstChildOfClass("Tool")) then
                                    Client.Character.Humanoid:UnequipTools()
                                end
                            else
                                if (Client.Backpack:FindFirstChild("Combat")) then
                                    Client.Character.Humanoid:EquipTool(Client.Backpack:FindFirstChild("Combat"))
                                else
                                    Client.Character:FindFirstChild("Combat"):Activate()
                                end
                            end

                            Client.Character.HumanoidRootPart.CFrame = ATM.Open.CFrame * CFrame.new(0, -10, 0)
                            Client.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        until Client.Character:FindFirstChildOfClass("Highlight") or Client.Character.BodyEffects.Dead.Value or not Settings.Enabled
                    end
                until ATM.Humanoid.Health <= 0 or Client.Character.BodyEffects.Dead.Value or not Settings.Enabled

                pcall(function()
                    for Index, Value in ipairs(game.Workspace.Ignored.Drop:GetChildren()) do
                        if Value.Name == "MoneyDrop" and (Client.Character.HumanoidRootPart.Position - Value.Position).Magnitude <= 25 then
                            local Delay = tick()
                            repeat task.wait()
                                if tick() - Delay <= 0.86 and Value:FindFirstChild("ClickDetector") then
                                    fireclickdetector(Value.ClickDetector)
                                end

                                Client.Character.HumanoidRootPart.CFrame = CFrame.new(Value.Position - Vector3.new(0, 8, 0))
                                Client.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            until Value.Parent == nil or not Settings.Enabled
                        end
                    end
                end)
            elseif (not ATM) then
                Serverhop()
            end
            
        end
    end)
    if (Error) then warn(string.format('Autofarm: %s', Error)) end
until not Settings.Enabled
