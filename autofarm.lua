--[[

ATM FARM (v1.0) (UNDERGOING FIXES)

--]]

script_key="LqWEpoHiknUHeTZouBdGfQxVRFoeAYKD";

-- Table
_G.configuration = {
    status = true,
    optimize = true, -- decreases gpu/mem usage
    disablerendering = false, -- decreases gpu usage
    screengui = false, -- screen gui that covers entire screen with information such as the amount of cash along with a combat indicator
    behavior = {
        pickupdelay = 0.7, -- pickupdelay to prevent kick
        furtherpickupdelay = 0.25, -- pickupdelay + furtherpickupdelay for further cash to prevent kick
        hospitalfarm = true, -- automatically completes hospital when idle
        shoefarm = true, -- automatically collects shoes when idle
        autobox = false, -- automatically boxes before farming
        fpscapacity = 8, -- decreases cpu usage (lower = less usage / higher = more usage)
    },
    purchases = {
        mask = true, -- automatically purchases and equips masks
        unjail = true, -- automatically purchases and uses key to unjail
    },
    serverhop = {
        leaveonknock = true, -- automatically serverhops when knocked
        timer = {
            usetimer = true, -- automatically serverhops after 'seconds' passes
            seconds = 300
        },
        playerjoinedhop = false, -- automatically serverhops when player with matching id in 'joinedids' joins
        joinedids = {

        },
        playerexistshop = false, -- automatically serverhops when player with matching id in 'existsids' already is in the server
        existsids = {
               
        },
    }
}
pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7c4e2dc9658d3af80fd0e0d1cd03f3d3.lua"))()
end)
