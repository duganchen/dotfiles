version = '0.21.3'

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

require("icons").setup()
require("extra-icons").setup()
require("one-table-column").setup()

xplr.config.general.initial_layout = "no_help_no_selection"

-- This works with the FISH function that starts xplr...
xplr.config.general.start_fifo = os.getenv("NNN_FIFO")
