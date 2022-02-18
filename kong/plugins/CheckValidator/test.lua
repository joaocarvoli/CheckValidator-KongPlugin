function Split(s, delimiter)
  result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match);
  end
  return result;
end

split_string = Split("bearer barramento", " ")
print(split_string[2])


[[--
-- local BasePlugin = require "kong.plugins.base_plugin"
local http = require("socket.http")
local json = require('json')
--local kong = kong
--local ngx = ngx

-- Functions to deal with response body

local headers = {
  authorization = "barramento"
}

local _, status = http.request({
  url = "https://google.com.br",
  headers = headers
})
print("STATUS CODE: ", status)

if status == 200 then
  return print("The token is valid!")
end
return print("The token is not valid!")

--function GetBody(url)
--  local body = http.request(url)
--  local decoded = ReadBody(body)
--  if decoded == nil then
--    return "There is no body"
--  end
--  return PrintTable(decoded)
--end


--function ReadBody(body)
--  if body then
--    return json.decode(body)
--  end
--  return nil
--end
--
--
--function PrintTable(tbl)
--  for key, value in pairs(tbl) do
--    print("The key is:", key) -- Returns a string
--    print("The value is:", value, "\n") -- Returns a boolean or another value...
--  end
--end

-- Authorization
-- Plugin

--local plugin = {
--  PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
--  VERSION = "0.1", -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.
--}
--
--local ResBody = BasePlugin:extend()
--
--
--function ResBody:new()
--  ResBody.super.new(self, "responseBody")
--end
--
--
--function ResBody:body_filter(conf)
--  ResBody.super.body_filter(self)
--
--  local headers = kong.req.get_headers()
--  for key, value in pairs(headers) do
--    print("The key is:", key) -- Returns a string
--    print("The value is:", value, "\n")
--  end
--end


--GetBody("http://localhost:3000/test") -- The url needs be a string


-- return ResBody

--]]