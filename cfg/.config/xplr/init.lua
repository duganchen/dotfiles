version = '0.21.3'

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

require("icons").setup()
require("extra-icons").setup()
require("one-table-column").setup({
    index = true
})

local map = require("map")
map.placeholders["{cwd}"] = function(node, meta)
    return xplr.util.shell_execute("pwd").stdout
end
map.setup()

require("find").setup {
    mode = "default",
    key = "F",
    templates = {
        ["find all"] = {
            key = "a",
            find_command = "fd",
            find_args = "-s ",
            cursor_position = 8
        },
        ["find files"] = {
            key = "f",
            find_command = "fd",
            find_args = "-s -t f ",
            cursor_position = 8
        },
        ["find directories"] = {
            key = "d",
            find_command = "fd",
            find_args = "s  -t d ",
            cursor_position = 8
        }
    },
    refresh_screen_key = "ctrl-r"
}

xplr.config.modes.custom.find.layout = "HelpMenu"

-- Gets extra-icons to work.
xplr.config.general.table.row.cols[2].format = "custom.icons_dtomvan_col_1"

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

local contextAndLogs = {
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

local t = xplr.config.layouts.builtin.default.Horizontal.splits[1].Vertical.splits
t[#t] = contextAndLogs
t = xplr.config.layouts.builtin.no_help.Horizontal.splits[1].Vertical.splits
t[#t] = contextAndLogs
t = xplr.config.layouts.builtin.no_selection.Horizontal.splits[1].Vertical.splits
t[#t] = contextAndLogs
t = xplr.config.layouts.builtin.no_help_no_selection.Vertical.splits
t[#t] = contextAndLogs

-- Make sort modal. This is needed to get them to work properly without an onscreen help pane.
xplr.config.modes.builtin.sort.layout = "HelpMenu"
for _, v in pairs(xplr.config.modes.builtin.sort.key_bindings.on_key) do
    table.insert(v.messages, "PopMode")
end

-- And some keybindings I find useful.

-- Directory bookmarks. With this:
-- https://github.com/duganchen/dirmarks

xplr.config.modes.builtin.default.key_bindings.on_key["m"] = {
    help = "Add permanent bookmark",
    messages = {{
        BashExec = [===[
          PTH="$(pwd)"
          dirmarks add "$PTH" ~/.dirmarks.json
          "$XPLR" -m 'LogSuccess: %q' "$PTH added to ~/.dirmarks.json"
        ]===]
    }}
}

xplr.config.modes.builtin.default.key_bindings.on_key["'"] = {
    help = "Jump to permanent bookmark",
    messages = {{
        BashExec = [===[
          PTH="$(dirmarks list $(pwd) ~/.dirmarks.json | fzf --no-sort --select-1 --exit-0)"
          if [ -d "$PTH" ]; then
            dirmark add "$PTH" ~/.dirmarks.json
            "$XPLR" -m 'ChangeDirectory: %q' "$PTH"
          fi
        ]===]
    }}
}

xplr.config.modes.builtin.default.key_bindings.on_key["e"] = {
    help = "Edit in vscode",
    messages = {{
        BashExec = [===[
          if [ -e "${XPLR_FOCUS_PATH}" ]; then
            code "${XPLR_FOCUS_PATH}"
          fi
        ]===]
    }}
}
