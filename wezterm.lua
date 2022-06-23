local wezterm = require "wezterm";
local isMac = wezterm.target_triple:find("darwin")

return {
	color_scheme = "JetBrains Darcula",
  font = wezterm.font("HackGen35 Console", { weight="Bold" }),
	font_size = 14,
	bypass_mouse_reporting_modifiers = isMac and "CMD" or '',
}
