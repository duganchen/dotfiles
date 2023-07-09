-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Catppuccin Mocha'

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Show which key table is active in the status area
wezterm.on('update-status', function(window, pane)
  local name = window:active_key_table()
  if name == 'tab_mode' then
    window:set_left_status('<t> TAB')
    window:set_right_status('<n> New / <x> Close / <TAB> Toggle')
  elseif name == 'pane_mode' then
    window:set_left_status('<p> PANE')
    window:set_right_status('<x> Close / <d> Down / <r> Right')
  elseif name == 'resize_mode' then
    window:set_left_status('<n> RESIZE')
    window:set_right_status('<+-> Move tab focus <←↓↑→> Move pane focus / <hklj> Increase to / <HJKL> Decrease from')
  elseif name then
    window:set_right_status('TABLE: ' .. name)
  else
    window:set_left_status('Ctrl + ... <p> PANE | <t> TAB | <n> RESIZE | <h> MOVE')
    window:set_right_status('')
  end

end)

local act = wezterm.action

config.keys = {
  -- { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  -- { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
  -- { key = '!', mods = 'CTRL', action = act.ActivateTab(0) },
  -- { key = '!', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
  -- { key = '\"', mods = 'ALT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
  -- { key = '\"', mods = 'SHIFT|ALT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
  -- { key = '#', mods = 'CTRL', action = act.ActivateTab(2) },
  -- { key = '#', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
  -- { key = '$', mods = 'CTRL', action = act.ActivateTab(3) },
  -- { key = '$', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
  -- { key = '%', mods = 'CTRL', action = act.ActivateTab(4) },
  -- { key = '%', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
  -- { key = '%', mods = 'ALT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
  -- { key = '%', mods = 'SHIFT|ALT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
  -- { key = '&', mods = 'CTRL', action = act.ActivateTab(6) },
  -- { key = '&', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
  --{ key = '\'', mods = 'SHIFT|ALT|CTRL', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
  -- { key = '(', mods = 'CTRL', action = act.ActivateTab(-1) },
  -- { key = '(', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
  { key = ')', mods = 'CTRL', action = act.ResetFontSize },
  { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
  -- { key = '*', mods = 'CTRL', action = act.ActivateTab(7) },
  -- { key = '*', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
  { key = '0', mods = 'SUPER', action = act.ResetFontSize },
  -- { key = '1', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
  -- { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
  -- { key = '2', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
  -- { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
  -- { key = '3', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
  -- { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
  -- { key = '4', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
  -- { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
  -- { key = '5', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
  -- { key = '5', mods = 'SHIFT|ALT|CTRL', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
  -- { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
  -- { key = '6', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
  -- { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
  -- { key = '7', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
  -- { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
  -- { key = '8', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
  -- { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
  -- { key = '9', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
  -- { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) },
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
  -- { key = '@', mods = 'CTRL', action = act.ActivateTab(1) },
  -- { key = '@', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
  { key = 'C', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'F', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'K', mods = 'CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'L', mods = 'CTRL', action = act.ShowDebugOverlay },
  { key = 'L', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
  { key = 'M', mods = 'CTRL', action = act.Hide },
  { key = 'M', mods = 'SHIFT|CTRL', action = act.Hide },
  { key = 'N', mods = 'CTRL', action = act.SpawnWindow },
  { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'P', mods = 'CTRL', action = act.ActivateCommandPalette },
  { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
  { key = 'R', mods = 'CTRL', action = act.ReloadConfiguration },
  { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  -- { key = 'T', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  -- { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'U', mods = 'CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  -- { key = 'W', mods = 'CTRL', action = act.CloseCurrentTab{ confirm = true } },
  -- { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },
  { key = 'X', mods = 'CTRL', action = act.ActivateCopyMode },
  { key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
  { key = 'Z', mods = 'CTRL', action = act.TogglePaneZoomState },
  { key = 'Z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
  -- { key = '[', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
  -- { key = ']', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
  -- { key = '^', mods = 'CTRL', action = act.ActivateTab(5) },
  -- { key = '^', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
  { key = '_', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
  { key = 'f', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
  { key = 'm', mods = 'SHIFT|CTRL', action = act.Hide },
  { key = 'm', mods = 'SUPER', action = act.Hide },
  { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
  { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
  { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
  -- { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  -- { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
  -- { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = true } },
  -- { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab{ confirm = true } },
  { key = 'x', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
  { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
  -- { key = '{', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
  -- { key = '{', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
  -- { key = '}', mods = 'SUPER', action = act.ActivateTabRelative(1) },
  -- { key = '}', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
  { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  -- { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  -- { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  -- { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  -- { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
  -- { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  -- { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
  -- { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  -- { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
  -- { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  -- { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
  -- { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
  -- { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
  { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
  { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
  { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },

  {
    key = 't', mods = 'CTRL', action = act.ActivateKeyTable {
      name = 'tab_mode',
      prevent_fallback = true
    },
  },

  {
    key = 'p', mods = 'CTRL', action = act.ActivateKeyTable {
      name = 'pane_mode',
      prevent_fallback = true,
    },
  },

  {
    key = 'h', mods = 'CTRL', action = act.PaneSelect {
      mode = 'SwapWithActive',
    },
  },

  {
    key = 'n', mods = 'CTRL', action = act.ActivateKeyTable {
      name = 'resize_mode',
      prevent_fallback = true,
      one_shot = false
    },
  },
}


config.key_tables = {
  copy_mode = {
    { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
    { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
    { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
    { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
    { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
    { key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
    { key = 'F', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
    { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
    { key = 'T', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
    { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
    { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
    { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
    { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
    { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
    { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
    { key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
    { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
    { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
    { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
    { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
    { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
    { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
    { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
    { key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
    { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
    { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
    { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
    { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
    { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
    { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
    { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
    { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
    { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
    { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
  },

  search_mode = {
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
    { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
    { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
  },

  tab_mode = {
    -- { key = 'LeftArrow', action = act.MoveTabRelative(-1) },
    -- { key = 'h', action = act.MoveTabRelative(-1) },
    -- { key = 'RightArrow', action = act.MoveTabRelative(1) },
    -- { key = 'l', action = act.MoveTabRelative(1) },
    { key = 'n', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'x', action = act.CloseCurrentTab{ confirm = false} },
    { key = '1', action = act.ActivateTab(0) },
    { key = '2', action = act.ActivateTab(1) },
    { key = '3', action = act.ActivateTab(2) },
    { key = '4', action = act.ActivateTab(3) },
    { key = '5', action = act.ActivateTab(4) },
    { key = '6', action = act.ActivateTab(5) },
    { key = '7', action = act.ActivateTab(6) },
    { key = '8', action = act.ActivateTab(7) },
    { key = '9', action = act.ActivateTab(8) },
    { key = 'Tab', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'Escape', action = 'PopKeyTable' },
  },

  pane_mode = {
    { key = 'd', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
    { key = 'r', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    -- { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    -- { key = 'l', action = act.ActivatePaneDirection 'Right' },
    -- { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    -- { key = 'j', action = act.ActivatePaneDirection 'Up' },
    -- { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    -- { key = 'k', action = act.ActivatePaneDirection 'Down' },
    -- { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'x', action = act.CloseCurrentPane {confirm = false} },
    { key = 'Escape', action = 'PopKeyTable' },
  },

  resize_mode = {
    { key = 'Escape', action = 'PopKeyTable' },

    { key = 'h', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'l', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'j', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize{ 'Down', 1 } },

    { key = 'H', mods = 'SHIFT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'L', mods = 'SHIFT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'J', mods = 'SHIFT', action = act.AdjustPaneSize{ 'Down', 1 } },
    { key = 'K', mods = 'SHIFT', action = act.AdjustPaneSize{ 'Up', 1 } },

    -- Move some of the navigation stuff here
    { key = '-', action = act.MoveTabRelative(-1)},

    -- This doesn't work for me.
    { key = '-', action = act.MoveTabRelative(1)},
    
    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
  },

}

-- and finally, return the configuration to wezterm
return config
