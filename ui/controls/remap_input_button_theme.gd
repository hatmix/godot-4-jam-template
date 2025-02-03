@tool
extends ProgrammaticTheme

const OUTLINE: Color = Color("341a1a")
const SHADOW: Color = Color("563d4d")
const BACKGROUND: Color = Color("64739c")
const PANEL: Color = Color("57aab6")
const SELECTED: Color = Color("90d8b4")
const TEXT: Color = Color("fff1da")


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

	define_style("RichTextLabel", {normal = stylebox_empty({})})

	define_style(
		"Button",
		{
			normal = stylebox_empty({}),
			focus = sb_focus,
			pressed = sb_focus,
			hover = inherit(sb_focus, stylebox_flat({border_color = Color.DIM_GRAY})),
		}
	)
