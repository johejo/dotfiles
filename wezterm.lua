local wezterm = require("wezterm")
local isMac = wezterm.target_triple:find("darwin")

return {
  color_scheme = "zenwritten_dark",
  font = wezterm.font("UDEV Gothic 35", { weight = "Bold" }),
  font_size = 12,
  bypass_mouse_reporting_modifiers = isMac and "CMD" or "SHIFT",
}
