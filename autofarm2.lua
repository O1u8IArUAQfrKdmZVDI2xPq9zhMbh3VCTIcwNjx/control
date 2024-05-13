_G.AutofarmSettings = {
    ["AttackMode"] = "2",
    --// ^ 1 - Fast Punch | 2 - Super Punch | 3 - Knife (PROB THE FASTEST).

    ["Fps"] = "15",
    --// ^ Wouldnt recommend going below 5. ^

    ["Codes"] = {
        'TRADEME!',
        'DAUP',
        'MELONBEAR',
        'HALLOWEEN2023',
        'pumpkins2023',
        'RUBY',
    }, 
    --// ^ (optional) Codes that will be automatically claimed. ^

    ["Webhook"] = "https://discord.com/api/webhooks/1239328532941901967/1LqQ821FSj0GGFQptJqGiyS2Sxu8yGafBK7IzM9BomXW9p_eJnzVOG6TJvM3jnmJfodz",
    --// ^ (optional) Webhook link that logs will be sent to. ^
    
    ["LogInterval"] = "60",
    --// ^ How often the logs will be sent in minutes.
    
    ["Credits"] = "iku autofarm - by @trans"
}
--\\ Services
local Players = game:GetService('Players');
local CoreGui = game:GetService('CoreGui')
local RunService = game:GetService('RunService');
local HTTPService = game:GetService('HttpService');
local VirtualUser = game:GetService('VirtualUser');
local TeleportService = game:GetService('TeleportService');
local ReplicatedStorage = game:GetService('ReplicatedStorage');

--\\ Variables
local Client = Players.LocalPlayer;
local Backpack = Client.Backpack;
local DataFolder = Client:WaitForChild('DataFolder');
local Information = DataFolder:WaitForChild('Information');
local register = workspace.Cashiers;
local ignored = workspace.Ignored;
local hospital = ignored.HospitalJob;
local drop = ignored.Drop;
local shop = ignored.Shop;

local function Serverhop()
    local PlaceID = game.PlaceId
    local Servers = HTTPService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/'.. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    local OpenServers = {}
    for _, Server in pairs(Servers.data) do
        if Server.playing ~= Server.maxPlayers and Server.playerIds ~= Client.UserId then
            table.insert(OpenServers, Server)
        end
    end

    TeleportService:TeleportToPlaceInstance(PlaceID, OpenServers[math.random(1, #OpenServers)].id)
end

task.delay(300, function()
    Serverhop()
end)


loadstring(game:HttpGet("https://github.com/applless/RandomScripts/raw/main/IkuAutofarm"))()
