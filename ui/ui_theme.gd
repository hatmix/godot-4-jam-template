@tool
extends ProgrammaticTheme

@warning_ignore("integer_division")

const OUTLINE: Color = Color("341a1a")
const SHADOW: Color = Color("563d4d")
const BACKGROUND: Color = Color("64739c")
const PANEL: Color = Color("57aab6")
const SELECTED: Color = Color("90d8b4")
const TEXT: Color = Color("fff1da")

const CORNERS: int = 8
const BORDERS: int = 2

var sb_round = stylebox_flat({corners_ = corner_radius(CORNERS)})
var sb_flat_bottom = stylebox_flat({corners_ = corner_radius(CORNERS, CORNERS, 0, 0)})
var sb_flat_top = stylebox_flat({corners_ = corner_radius(0, 0, CORNERS, CORNERS)})

var sb_button_normal = stylebox_flat(
	{
		bg_color = Color.TRANSPARENT,
	}
)
var sb_button_focus = inherit(sb_button_normal, {})
var sb_button_hover = inherit(sb_button_normal, {})
var sb_button_pressed = inherit(sb_button_normal, {})


# The project's default theme is set to res://ui/ui_theme.tres
func setup() -> void:
	set_save_path("res://ui/ui_theme.tres")


func define_theme() -> void:
	define_default_font(ResourceLoader.load("res://ui/assets/fonts/BlackHanSans-Regular.ttf"))
	define_default_font_size(16)

	define_style(
		"Button",
		{
			font_color = TEXT,
			font_focus_color = PANEL,
			font_hover_color = PANEL,
			font_hover_pressed_color = TEXT,
			font_pressed_color = TEXT,
			font_disabled_color = SHADOW,
			icon_normal_color = TEXT,
			icon_focus_color = PANEL,
			icon_hover_color = PANEL,
			icon_hover_pressed_color = TEXT,
			icon_pressed_color = TEXT,
			icon_disabled_color = SHADOW,
			outline_size = 8,
			font_outline_color = OUTLINE,
			normal = sb_button_normal,
			focus = sb_button_focus,
			hover = sb_button_hover,
			pressed = sb_button_pressed,
		}
	)
