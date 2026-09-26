require("starship"):setup({
	hide_flags = false,
	flags_after_prompt = true,
	config_file = "~/.config/starship_full.toml",
	show_right_prompt = false,
	hide_count = false,
	count_separator = " ",
})

require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("git"):setup({
	order = 1500,
})
