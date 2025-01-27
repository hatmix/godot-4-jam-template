@tool
extends ProgrammaticTheme

@warning_ignore("integer_division")


# The project's default theme is set to res://ui/ui_theme.tres
func setup() -> void:
	set_save_path("res://ui/ui_theme.tres")


# TODO: define UI theme below with ThemeGen (or manually edit res://ui/ui_theme.tres)
func define_theme() -> void:
	#define_default_font(ResourceLoader.load("res://ui/assets/fonts/Sixtyfour-Regular.ttf"))
	#define_default_font_size(16)

	define_style(
		"Button",
		{
			font_color = Color("#dfdfdf"),
		}
	)
