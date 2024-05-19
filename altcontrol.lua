--[[

ALT CONTROL (v1.0)

Command List
dropcash on/off -- Usage "dropcash on" "dropcash off" || Drops cash on all alts
airlock on/off -- Usage "airlock on" "airlock off" || Puts alts in the air
underground on/off -- Usage "underground on" "underground off" || Puts alts underground
setup club/bank/custom -- Usage "setup bank" "setup club" "setup custom" || Sets up alts at the specified area
unload -- Usage "unload" || Force stops everything, use this in emergencies
deletecash -- Usage "deletecash" || permanetly hides / deletes cash

--]]

script_key="LqWEpoHiknUHeTZouBdGfQxVRFoeAYKD";

_G.configuration = {
    host = 'Astonlix', -- username or displayname or userid
    prefix = '/',
    framecap = 3,
    setups = {
        ['bank'] = 'https://raw.githubusercontent.com/polarsblade/setups/main/bank',
        ['club'] = 'https://raw.githubusercontent.com/polarsblade/setups/main/club',
    },
    altaccounts = {
        
        "djgyya",
        "annyrapma",
        "mssjbshddgehdhe",
        "cowpro7000",
        "uhVurelix",
        --[[
        "timur190101",
        "Alterlix1",
        "Alterlix2",
        "Alterlix3",
        "Alterlix4",
        "Alterlix5",
        "Alterlix6",
        "Alterlix7",
        "Alterlix8",
        "Alterlix9",
        "Alterlix10",
        "Alterlix12",
        "Alterlix11",
        "Alterlix13",
        "Alterlix14",
        "Alterlix15",
        "Alterlix16",
        "Alterlix17",
        "Alterlix18",
        "Alterlix19",
        "Alterlix20",
        --]]
        "PrestigeDHC1",
        "PrestigeDHC5",
        "PrestigeDHC7",
        "PrestigeDHC10",
        "PrestigeDHC3",
        "PrestigeDHC8",
        "PrestigeDHC9",
        "PrestigeDHC6",
        "PrestigeDHC2",
        "progarillamadmar",
    }
}

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/5ff0682a1a30e535a1bcac010be61a9f.lua"))()
