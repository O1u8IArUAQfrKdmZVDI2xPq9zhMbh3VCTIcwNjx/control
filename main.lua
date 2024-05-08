local mode = loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/mode.lua'))()

if (mode == 0 or mode == 'none') then
    return
elseif (mode == 1 or mode == 'altcontrol') then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/altcontrol.lua'))()
elseif (mode == 2 or mode == 'autofarm') then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/autofarm.lua'))()
elseif mode == 3 then
--[[

ATM FARM (v1.0) (UNDERGOING FIXES)

--]]

script_key="PkBzjxdqfjtqDpHUoyBQGNDyReieScGt";

-- Table
_G.configuration = {
    status = true,
    optimize = true, -- decreases gpu/mem usage
    disablerendering = true, -- decreases gpu usage
    screengui = true, -- screen gui that covers entire screen with information such as the amount of cash along with a combat indicator
    behavior = {
        pickupdelay = 0.7, -- pickupdelay to prevent kick
        furtherpickupdelay = 0.25, -- pickupdelay + furtherpickupdelay for further cash to prevent kick
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
        leaveonknock = false, -- automatically serverhops when knocked
        timer = {
            usetimer = false, -- automatically serverhops after 'seconds' passes
            seconds = 60
        },
        playerjoinedhop = false, -- automatically serverhops when player with matching id in 'joinedids' joins
        joinedids = {

        },
        playerexistshop = false, -- automatically serverhops when player with matching id in 'existsids' already is in the server
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

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7c4e2dc9658d3af80fd0e0d1cd03f3d3.lua"))()

end
