package = "kong-rewrite-plugin-test"
version = "0.1.1-0"
source = {
   url = "git://github.com/sabir-piludiya/kong-rewrite-plugin-test",
}
description = {
  summary = "KongAPI Gateway middleware plugin for url-rewrite purposes.",
  license = "Apache License 2.0"
}
dependencies = {
  "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
    ["kong.plugins.kong-rewrite-plugin-test.handler"] = "src/handler.lua",
    ["kong.plugins.kong-rewrite-plugin-test.schema"] = "src/schema.lua"
   }
}
