version = '0.21.2'

local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path

require("icons").setup()
require("extra-icons").setup()

xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }

-- Limit the columns to path and size.

xplr.config.general.table.header.cols = {
  -- { format = "index",            style = {} },
  { format = "╭─── path", style = {} },
  -- { format = "perm",              style = {} },
  -- { format = "size",              style = {} },
  -- { format = "modified",          style = {} },
}

xplr.config.general.table.row.cols = {
  -- {
  --   format = "builtin.fmt_general_table_row_cols_0",
  --   style = {},
  -- },
  {
    format = "builtin.fmt_general_table_row_cols_1",
    style = {},
  },
  -- {
  --   format = "builtin.fmt_general_table_row_cols_2",
  --   style = {},
  -- },
  -- {
  --   format = "builtin.fmt_general_table_row_cols_3",
  --   style = {},
  -- },
  -- {
  --   format = "builtin.fmt_general_table_row_cols_4",
  --   style = {},
  -- },
}

xplr.config.general.table.col_widths = {
  -- { Percentage = 10 },
  { Percentage = 100 },
  -- { Percentage = 10 },
  -- { Percentage = 10 },
  -- { Percentage = 20 },
}

xplr.config.general.start_fifo = os.getenv("NNN_FIFO")

xplr.config.general.initial_layout = "no_help_no_selection"

xplr.fn.custom.stat_pane = {}
xplr.fn.custom.stat_pane.render = function(ctx)

  local body = xplr.fn.builtin.fmt_general_table_row_cols_2(ctx.app.focused_node)
  .. " "
  ..
  xplr.fn.builtin.fmt_general_table_row_cols_3(ctx.app.focused_node)
  .. " "
  .. xplr.fn.builtin.fmt_general_table_row_cols_4(ctx.app.focused_node)


  return { CustomParagraph = { ui = { title = nil }, body = body} }
end

local stat_pane = { Dynamic = "custom.stat_pane.render" }

xplr.config.layouts.builtin.no_help_no_selection = {
  Vertical = {
    config = {
      constraints = {
        { Length = 3 },
        { Min = 1 },
        { Length = 3 },
        { Length = 3 },
      },
    },
    splits = {
      "SortAndFilter",
      "Table",
      stat_pane,
      "InputAndLogs",
    },
  },
}

xplr.config.modes.custom.bookmarks = {
  name = "bookmarks",
  layout = "HelpMenu",
  key_bindings = {
    on_key = {
      s = {
        help = "search",
        messages = {
          {
            BashExec = [===[
              PTH="${XPLR_FOCUS_PATH:?}"
              PTH_ESC=$(/usr/bin/printf %q "$PTH")
              "$XPLR" -m 'LogSuccess: %q' "$PTH_ESC added to bookmarks"
              if [ -d "$PTH_ESC" ]; then
                "$XPLR" -m 'LogSuccess: %q' "$PTH_ESC added to bookmarks"
              else
                "$XPLR" -m 'LogError: %q' "Not a directory"
              fi
            ]===]
          },
          "PopMode",
        },
      },
      c = {
        help = "clear",
        messages = {
          {
            BashExec = [===[
              "$XPLR" -m 'LogSuccess: %q' "All bookmarks removed"
            ]===]
          },
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "PopMode",
      },
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["m"] = {
  help = "bookmarks mode",
  messages = {
    { SwitchModeCustom = "bookmarks" },
  },
}