local xplr = xplr

local function setup(args)

    -- Don't need the column headers anymore.
    xplr.config.general.table.header.cols = {}

    -- We only need the path column.
    xplr.config.general.table.row.cols = {{
        format = "builtin.fmt_general_table_row_cols_1",
        style = {}
    }}

    -- It now takes up the entire table
    xplr.config.general.table.col_widths = {{
        Percentage = 100
    }}

    -- Move information that used to be in the other columns to a separate "layout"
    local function render(ctx)

        local body = ""
        if ctx.app.focused_node then
            body = xplr.fn.builtin.fmt_general_table_row_cols_2(ctx.app.focused_node) .. " " ..
                       xplr.fn.builtin.fmt_general_table_row_cols_3(ctx.app.focused_node) .. " " ..
                       xplr.fn.builtin.fmt_general_table_row_cols_4(ctx.app.focused_node)
        end

        return {
            CustomParagraph = {
                ui = {
                    title = nil
                },
                body = body
            }
        }
    end

    xplr.fn.custom.stats = {
        render = render
    }

    xplr.config.layouts.custom.Stats = {
        Dynamic = "custom.stats.render"
    }

    -- And insert that layout into the existing layouts, between the table and the input-and-logs.

    -- Default
    local t = xplr.config.layouts.builtin.default.Horizontal.splits[1].Vertical.config.constraints
    table.insert(t, #t, {
        Length = 3
    })
    t = xplr.config.layouts.builtin.default.Horizontal.splits[1].Vertical.splits
    table.insert(t, #t, xplr.config.layouts.custom.Stats)

    -- No Help
    t = xplr.config.layouts.builtin.no_help.Horizontal.splits[1].Vertical.config.constraints
    table.insert(t, #t, {
        Length = 3
    })
    t = xplr.config.layouts.builtin.no_help.Horizontal.splits[1].Vertical.splits
    table.insert(t, #t, xplr.config.layouts.custom.Stats)

    -- No Selection
    t = xplr.config.layouts.builtin.no_selection.Horizontal.splits[1].Vertical.config.constraints
    table.insert(t, #t, {
        Length = 3
    })
    t = xplr.config.layouts.builtin.no_selection.Horizontal.splits[1].Vertical.splits
    table.insert(t, #t, xplr.config.layouts.custom.Stats)

    -- No Help No Selection
    t = xplr.config.layouts.builtin.no_help_no_selection.Vertical.config.constraints
    table.insert(t, #t, {
        Length = 3
    })
    t = xplr.config.layouts.builtin.no_help_no_selection.Vertical.splits
    table.insert(t, #t, xplr.config.layouts.custom.Stats)
end

return {
    setup = setup
}
