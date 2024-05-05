local mode = loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/mode.lua'))()

if mode == 0 then
  return print('no')
elseif mode == 1 then
  print("hello world")
elseif mode == 2 then
  print('ac')
elseif mode == 4 then
  loadstring(game:HttpGet('https://raw.githubusercontent.com/O1u8IArUAQfrKdmZVDI2xPq9zhMbh3VCTIcwNjx/control/main/autofarm'))()

end
