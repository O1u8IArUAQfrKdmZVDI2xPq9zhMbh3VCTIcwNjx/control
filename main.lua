local mode = loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/mode.lua'))()

if (mode == 0 or mode == 'none') then
    return
elseif (mode == 1 or mode == 'altcontrol') then
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/altcontrol.lua'))()
elseif (mode == 2 or mode == 'autofarm') then
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/autofarm2.lua'))()
end
