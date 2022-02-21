local BasePlugin = require "kong.plugins.base_plugin"
local http = require("socket.http")
local kong = kong

local ResKeyModHandler = BasePlugin:extend()

function ResKeyModHandler:new()
  ResKeyModHandler.super.new(self, "checkvalidator")
end

function ResKeyModHandler:access(conf)
  ResKeyModHandler.super.access(self)
  -- Getting request headers
	local header = ngx.req.get_headers()
	local headerContent = header["authorization"]
	-- Splitting the header content to get the token
	Content = ""
  for token in string.gmatch(headerContent, "[^%s]+") do
    if token ~= "Bearer" then
      Content = token
    end
  end
  local headers = {
    authorization = Content
  }
  -- Do request to SSO
  local _, status = http.request({
    url = "https://google.com.br",
    headers = headers
  })
  -- Determining the app flow according to status
  if status == 401 then
    ResKeyModHandler.status = 401
    kong.response.exit(403, "Forbidden: Invalid token") -- This function interrupts the current processing and produces a response.
    -- Kong doesn't support 401 status
  end
  ResKeyModHandler.status = 200
	print("SUCESS: Valid Token!")
end

ResKeyModHandler.PRIORITY = 800
ResKeyModHandler.VERSION = "1.0.0"

return ResKeyModHandler
