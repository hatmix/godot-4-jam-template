@tool
extends ProgrammaticTheme

@warning_ignore("integer_division")


# The project's default theme is set to res://ui/ui_theme.tres
func setup() -> void:
	set_save_path("res://ui/ui_theme.tres")


# TODO: Consider defining the UI theme below with ThemeGen or manually edit res://ui/ui_theme.tres
func define_theme() -> void:
	#define_default_font(ResourceLoader.load("res://ui/assets/fonts/Sixtyfour-Regular.ttf"))
	#define_default_font_size(16)

	define_style(
		"Button",
		{
			font_color = Color("#dfdfdf"),
		}
	)

#region Message (notifications) controls styling
	define_variant_style("MessagePanelContainer", "PanelContainer", {})
	define_variant_style("MessageLabel", "Label", {})
#endregion

#region Remapping controls styling
	# Buttons used for remapping controls are styled to have just a border for hover and focus
	var sb_remap_button_focused = stylebox_flat(
		{
			border_ = border_width(2),
			border_color = Color.WHITE,
			corners_ = corner_radius(2),
			bg_color = Color.TRANSPARENT,
		}
	)
	define_variant_style(
		"RemapButton",
		"Button",
		{
			normal = stylebox_empty({}),
			focus = sb_remap_button_focused,
			pressed = sb_remap_button_focused,
			hover =
			inherit(sb_remap_button_focused, stylebox_flat({border_color = Color.DIM_GRAY})),
		}
	)
	# Empty style to prevent other style changes from affecting controls UI... but does it?
	define_variant_style("RemapRichTextLabel", "RichTextLabel", {})
#endregion
