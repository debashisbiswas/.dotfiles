local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font_size = 16
config.window_background_opacity = 0.9
config.force_reverse_video_cursor = true
config.color_scheme = "Catppuccin Mocha"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.font = wezterm.font({ family = "Iosevka", weight = "DemiBold" })

return config
