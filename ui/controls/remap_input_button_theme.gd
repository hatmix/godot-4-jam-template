@tool
extends ProgrammaticTheme


func setup() -> void:
	set_save_path("res://ui/controls/remap_input_button_theme.tres")


# Called when the script is executed (using File -> Run in Script Editor).
func define_theme() -> void:
	var sb_focus = stylebox_flat(
		{
			border_ = border_width(2),
			border_color = Color.WHITE,
			corners_ = corner_radius(2),
			bg_color = Color.TRANSPARENT,
		}
	)

	define_style(
		"Button",
		{
			normal = stylebox_empty({}),
			focus = sb_focus,
			pressed = sb_focus,
			hover = inherit(sb_focus, stylebox_flat({border_color = Color.DIM_GRAY})),
		}
	)
