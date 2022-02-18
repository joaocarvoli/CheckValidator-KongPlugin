local BasePlugin = require "kong.plugins.base_plugin"
-- local access = "kong.plugins.checkerPlugin.access"
local http = require("socket.http")
local ngx = ngx
local kong = kong
local env = require("env")


local CheckValidator = BasePlugin:extend()

CheckValidator.PRIORITY = 1000 -- set the plugin priority, which determines plugin execution order
CheckValidator.VERSION = "0.1" -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.

function CheckValidator:new()
  CheckValidator.super.new(self, "checkerPlugin")
end 

-- Function that realizes the split of authorization header content
function Split(s, delimiter)
  result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match);
  end
  return result;
end

function CheckValidator:access(conf)
  CheckValidator.super.access(self)
-- acess: Executed for every request from a client and before it is being proxied to the upstream service.

  -- Getting request headers
  local header = ngx.req.get_headers()
  local headerContent = header["authorization"]

  -- Splitting the header content to get the token
  local token = Split(headerContent, " ")
  local headers = {
    authorization = token[2] -- token[2] == content of 'authorization' header
  }
  -- Do request to SSO
  local _, status = http.request({
    url = env.URL,
    headers = headers
  })
  -- Determining the app flow according to status
  if status == 401 then
    CheckValidator.status = 401
    kong.response.exit(403, "Forbidden: Invalid token") -- This function interrupts the current processing and produces a response.
    -- Kong doesn't support 401 status
  end
  CheckValidator.status = 200
end

return CheckValidator






