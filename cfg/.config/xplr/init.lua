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
        help = "Save the focused ndoe as a temporary bookmark",
        messages = {
          {
            BashExec = [===[
              PTH="$(pwd)"
              dirmarks add "$PTH" "$XPLR_SESSION_PATH/bookmarks.json"
              "$XPLR" -m 'LogSuccess: %q' "$PTH added to $XPLR_SESSION_PATH/bookmarks.json"
            ]===]
          },
          "PopMode",
        },
      },
      c = {
        help = "Clears away all temporary bookmarks",
        messages = {
          {
            BashExec = [===[
              dirmarks clear "$XPLR_SESSION_PATH/bookmarks.json"
              "$XPLR" -m 'LogSuccess: %q' "All bookmarks removed"
            ]===]
          },
          "PopMode",
        },
      },
      l = {
        help = "list",
        messages = {
          {
            BashExec = [===[
              dirmarks listall "$XPLR_SESSION_PATH/bookmarks.json" | less -+F
            ]===]
          },
          "PopMode",
        },
      },
      d = {
        help = "Delete focused node from bookmarks",
        messages = {
          {
            BashExec = [===[
              PTH="$(pwd)"
              dirmarks delete "$PTH" "$XPLR_SESSION_PATH/bookmarks.json"
              "$XPLR" -m 'LogSuccess: %q' "$PTH deleted from $XPLR_SESSION_PATH/bookmarks.json"
            ]===]
          },
          "PopMode",
        },
      },

      j = {
        help = "jump to temp bookmark",
        messages = {
          {
            BashExec = [===[
              PTH="$(dirmarks list $(pwd) $XPLR_SESSION_PATH/bookmarks.json | fzf --no-sort --select-1 --exit-0)"
              if [ -d "$PTH" ]; then
                dirmark add "$PTH"
                "$XPLR" -m 'ChangeDirectory: %q' "$PTH"
              fi
            ]===]
          },
          "PopMode",
        },
      }
    },
    default = {
      messages = {
        "PopMode",
      },
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["b"] = {
  help = "bookmarks mode",
  messages = {
    { SwitchModeCustom = "bookmarks" },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["m"] = {
  help = "Add permanent bookmark",
  messages = {
    {
      BashExec = [===[
        "$XPLR" -m 'LogSuccess: %q' "Adding permanent bookmark"
      ]===]
    }
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["'"] = {
  help = "Jump to permanent bookmark",
  messages = {
    {
      BashExec = [===[
        "$XPLR" -m 'LogSuccess: %q' "Jumping to permanent bookmark"
      ]===]
    }
  },
}