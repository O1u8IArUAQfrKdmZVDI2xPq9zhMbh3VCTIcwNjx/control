--[[

Polars ATM Autofarm v2.0

--]]

script_key="LqWEpoHiknUHeTZouBdGfQxVRFoeAYKD";

-- configuration
_G.configuration = {
    behavior = {
        fps = 5,
        rendering = false,
        optimize = true,
        gui = true,
    },
    cash = {
        pickup = 0.7,
        distancepickup = 0.25,
    },
    farming = {
        shoe = true,
        hospital = true,
        spawnedcash = true,
    },
    weapon = {
        defaultmoveset = false,
        boxingmoveset = true,
    },
    other = {
        mask = true,
        unjail = true,
    },
    serverhop = {
        onknocked = true,
        onjoined = false,
        joinedids = {
        },
        onloaded = true,
        loadedids = {
            5706602113,
            5706603909,
            5706604496,
            5706605412,
            5706606179,
            5706606908,
            5706607635,
            5706608267,
            5706608925,
            5706609759,
            5706637172,
            5706637724,
            5706638428,
            5706640295,
            5706640395,
            5706641420,
            5706643572,
            5706644333,
            5706645135,
            5706645941,
            3628437846,
            3628448372,
            3628451840,
            3628701286,
            3010069949,
            3628710317,
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
            3628439595,
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
        },
    },
}

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7c4e2dc9658d3af80fd0e0d1cd03f3d3.lua"))()
