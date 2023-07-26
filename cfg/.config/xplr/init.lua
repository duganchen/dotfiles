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

-- Make sorting work with the layout.
-- Add layout="HelpMenu" and the PopModes

xplr.config.modes.builtin.sort = {
  name = "sort",
  layout = "HelpMenu",
  key_bindings = {
    on_key = {
      ["!"] = {
        help = "reverse sorters",
        messages = {
          "ReverseNodeSorters",
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["E"] = {
        help = "by canonical extension reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByCanonicalExtension", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["M"] = {
        help = "by canonical mime essence reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByCanonicalMimeEssence", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["N"] = {
        help = "by node type reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByCanonicalIsDir", reverse = true } },
          { AddNodeSorter = { sorter = "ByCanonicalIsFile", reverse = true } },
          { AddNodeSorter = { sorter = "ByIsSymlink", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["R"] = {
        help = "by relative path reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByIRelativePath", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["S"] = {
        help = "by size reverse",
        messages = {
          { AddNodeSorter = { sorter = "BySize", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["backspace"] = {
        help = "remove last sorter",
        messages = {
          "RemoveLastNodeSorter",
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["ctrl-r"] = {
        help = "reset sorters",
        messages = {
          "ResetNodeSorters",
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["ctrl-u"] = {
        help = "clear sorters",
        messages = {
          "ClearNodeSorters",
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["e"] = {
        help = "by canonical extension",
        messages = {
          { AddNodeSorter = { sorter = "ByCanonicalExtension", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["enter"] = {
        help = "submit",
        messages = {
          "PopModeKeepingInputBuffer",
          "PopMode",
        },
      },
      ["esc"] = {
        messages = {
          "PopModeKeepingInputBuffer",
          "PopMode",
        },
      },
      ["m"] = {
        help = "by canonical mime essence",
        messages = {
          { AddNodeSorter = { sorter = "ByCanonicalMimeEssence", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["n"] = {
        help = "by node type",
        messages = {
          { AddNodeSorter = { sorter = "ByCanonicalIsDir", reverse = false } },
          { AddNodeSorter = { sorter = "ByCanonicalIsFile", reverse = false } },
          { AddNodeSorter = { sorter = "ByIsSymlink", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["r"] = {
        help = "by relative path",
        messages = {
          { AddNodeSorter = { sorter = "ByIRelativePath", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["s"] = {
        help = "by size",
        messages = {
          { AddNodeSorter = { sorter = "BySize", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["c"] = {
        help = "by created",
        messages = {
          { AddNodeSorter = { sorter = "ByCreated", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["C"] = {
        help = "by created reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByCreated", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["l"] = {
        help = "by last modified",
        messages = {
          { AddNodeSorter = { sorter = "ByLastModified", reverse = false } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["L"] = {
        help = "by last modified reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByLastModified", reverse = true } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
    },
  },
}
