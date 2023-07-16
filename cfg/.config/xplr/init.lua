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
  { format = "index",            style = {} },
  { format = "╭─── path", style = {} },
  -- { format = "perm",              style = {} },
  { format = "size",              style = {} },
  -- { format = "modified",          style = {} },
}

xplr.config.general.table.row.cols = {
  {
    format = "builtin.fmt_general_table_row_cols_0",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_1",
    style = {},
  },
  -- {
  --   format = "builtin.fmt_general_table_row_cols_2",
  --   style = {},
  -- },
  {
    format = "builtin.fmt_general_table_row_cols_3",
    style = {},
  },
  -- {
  --   format = "builtin.fmt_general_table_row_cols_4",
  --   style = {},
  -- },
}

xplr.config.general.table.col_widths = {
  { Percentage = 10 },
  { Percentage = 80 },
  -- { Percentage = 10 },
  { Percentage = 10 },
  -- { Percentage = 20 },
}

function get_fifo()
  if os.getenv("TERM_PROGRAM") == "WezTerm" then
    return "/tmp/nnn.fifo"
  end
  return nil
end

xplr.config.general.start_fifo = get_fifo()
