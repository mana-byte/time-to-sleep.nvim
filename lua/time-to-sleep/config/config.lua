local table_utils = require("time-to-sleep.utils.table")
local default_config = require("time-to-sleep.config.default_config")

default_config.configured = false
-- Load the user configuration file PLS
default_config.configure = function(config)
    default_config.configured = true
    table_utils.setValues(default_config, config)
end

return default_config
