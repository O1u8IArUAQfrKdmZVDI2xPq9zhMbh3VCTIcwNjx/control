getgenv().speed = 80 --higher = more likely to get kicked
getgenv().fps = 15
getgenv().farmerSettings = {
    DiscordWebhook = "https://discord.com/api/webhooks/1239328532941901967/1LqQ821FSj0GGFQptJqGiyS2Sxu8yGafBK7IzM9BomXW9p_eJnzVOG6TJvM3jnmJfodz", -- Put your Discord webhook here
    UpdateIntervals = 60, -- Number of minutes to wait before sending a farm update to Discord channel
}

while true do
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BDHScripts/bdhfarmer/main/Atmfarmer.lua"))()
    wait(3600) -- restarts script in 1 hour
end
