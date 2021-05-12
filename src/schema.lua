return {
    no_consumer = true,
    fields = {
        regex = { type = "string" },
        replacement = { type = "string" },
        flag = {type = "string"},
    },
    self_check = function(schema, plugin_t, dao, is_update)
        return true
    end
}
