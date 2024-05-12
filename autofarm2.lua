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

loadstring(game:HttpGet("https://github.com/applless/RandomScripts/raw/main/IkuAutofarm"))()
