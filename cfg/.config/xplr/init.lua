version = '0.21.3'

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

require("icons").setup()
require("extra-icons").setup()
require("one-table-column").setup()

-- The default key conflicts with my WezTerm setup. We change it to "c".
local csw = require("context-switch")
csw.setup({
    key = "c",
    layout = csw.builtin_layouts.without_help
})

xplr.config.general.initial_layout = "no_help_no_selection"

-- This works with the FISH function that starts xplr...
xplr.config.general.start_fifo = os.getenv("NNN_FIFO")

xplr.fn.custom.render_context_num = function(ctx)
    return {
        CustomParagraph = {
            ui = {
                title = {
                    format = "Ctx"
                }
            },
            body = '  ' .. tostring(csw.get_current_context_num())
        }
    }
end

-- Add the context window to the left of the logs.

local contextAndLayout = {
    Horizontal = {
        config = {
            constraints = {{
                Min = 7
            }, {
                Min = 1
            }}
        },
        splits = {{
            Dynamic = "custom.render_context_num"
        }, "InputAndLogs"}
    }
}

-- Notice that it's index 4 because we inserted the stats pane.
xplr.config.layouts.builtin.default.Horizontal.splits[1].Vertical.splits[4] = contextAndLayout
xplr.config.layouts.builtin.no_help.Horizontal.splits[1].Vertical.splits[4] = contextAndLayout
xplr.config.layouts.builtin.no_selection.Horizontal.splits[1].Vertical.splits[4] = contextAndLayout
xplr.config.layouts.builtin.no_help_no_selection.Vertical.splits[4] = contextAndLayout

-- Make sort modal. This is needed to get them to work properly without an onscreen help pane.
xplr.config.modes.builtin.sort.layout = "HelpMenu"
for _, v in pairs(xplr.config.modes.builtin.sort.key_bindings.on_key) do
    table.insert(v.messages, "PopMode")
end
