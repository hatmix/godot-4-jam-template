@tool
extends ProgrammaticTheme

@warning_ignore("integer_division")

# Called when the script is executed (using File -> Run in Script Editor).
func setup() -> void:
	set_save_path("res://ui/ui_theme.tres")



func define_theme() -> void:
	#define_default_font(ResourceLoader.load("res://Delight Snowy.otf"))
	#define_default_font_size(16)
	
	define_style("Button", {
		font_color = Color("#dfdfdf"),
	})
