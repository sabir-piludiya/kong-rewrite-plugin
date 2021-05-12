local BasePlugin = require "kong.plugins.base_plugin"
local json = require("cjson")
local RewriteHandler = BasePlugin:extend()
local ngx = ngx
local kong = kong

RewriteHandler.PRIORITY = 2000
RewriteHandler.VERSION = "0.1.0"

function RewriteHandler:access(conf)
    RewriteHandler.super.access(self)

    local host = ngx.var.host
    kong.log("Debug http-rewrite plugin, host is: ", host, " ,uri is: ", ngx.var.request_uri, " service is: ",service," ,config is: ", json.encode(conf))

    kong.log("Debug http-rewrite plugin, regex is: ",regex, " replacement is : ",replacement)
    local replace,n,err  = ngx.re.sub(ngx.var.request_uri, conf.regex, conf.replacement)
    if replace and n == 0 then
        return
    end

    if err then
        kong.log("Error http-rewrite plugin, ngx.re.sub err: ",err, " ,host is: ", host, " ,uri is: ",
            ngx.var.request_uri, " ,config is: ", json.encode(conf))
        return
    end

    kong.log("Debug http-rewrite plugin, replace is: ",replace)
    if conf.flag == "redirect" then
        ngx.redirect(replace,302)
    elseif conf.flag == "permanent" then
        ngx.redirect(replace,301)
    end
end

function RewriteHandler:new()
    RewriteHandler.super.new(self, "http-rewrite")
end

return RewriteHandler
