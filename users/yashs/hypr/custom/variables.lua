-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 1,
		col = {
			active_border = "rgb(7c6f64)",
			inactive_border = "rgb(141617)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "master",
	},

	master = {
		mfact = 0.55,
	},

	misc = {
		initial_workspace_tracking = 0,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		font_family = "sans-serif",
		animate_manual_resizes = false,
		focus_on_activate = true,
		middle_click_paste = false,
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
		},
		blur = {
			enabled = false,
		},
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "fn:super_l",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},

	xwayland = {
		force_zero_scaling = true,
	},

	cursor = {
		inactive_timeout = 5,
		no_warps = true,
		hide_on_key_press = false,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
		enforce_permissions = true,
	},

	animations = {
		enabled = false,
	},
})
