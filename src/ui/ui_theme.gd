@tool
extends ProgrammaticTheme
# Note that ProgrammaticTheme stylebox_ functions return Dictionary objects, not StyleBox

@warning_ignore("integer_division")
# The project's default theme is set to res://ui/ui_theme.tres
func setup() -> void:
	set_save_path("res://src/ui/ui_theme.tres")


# TODO: Consider defining the UI theme below with ThemeGen or manually edit res://ui/ui_theme.tres
func define_theme() -> void:
	define_default_font(load("res://src/ui/assets/fonts/Lato-Black.ttf"))
	define_default_font_size(48)

	# Uncomment to set splash and clear colors in settings.
	# Not technically part of the theme, but usually changed together
	#ProjectSettings.set_setting("rendering/environment/defaults/default_clear_color", Color.BLACK)
	#ProjectSettings.set_setting("application/boot_splash/bg_color", Color.BLACK)

#region Control Styles
	#define_style("BoxContainer", {})
	#define_style("Button", {})
	# define_style("CheckBox", {})
	#define_style("CheckButton", {})
	#define_style("CodeEdit", {})

	# Leaving out the Color* styling

	#define_style("FlatButton", {})
	#define_style("FlatMenuButton", {})
	#define_style("FlowContainer", {})
	#define_style("FoldableContainer", {})

	# Leaving out the Graph* styling

	#define_style("GridContainer", {})

	# Grouping H* & V* nodes
	#define_style("HBoxContainer", {})
	#define_style("VBoxContainer", {})
	#define_style("HFlowContainer", {})
	#define_style("VFlowContainer", {})
	#define_style("HScrollBar", {})
	#define_style("VScrollBar", {})
	#define_style("HSeparator", {})
	#define_style("VSeparator", {})
	#define_style("HSlider", {})
	#define_style("VSlider", {})
	#define_style("HSplitContainer", {})
	#define_style("VSplitContainer", {})
	#define_style("ItemList", {})
	#define_style("Label", {})
	#define_style("LineEdit", {})
	#define_style("LinkButton", {})
	#define_style("MarginContainer", {})
	#define_style("MenuBar", {})
	#define_style("MenuButton", {})
	#define_style("OptionButton", {})
	#define_style("Panel", {})
	#define_style("PanelContainer", {})
	#define_style("ProgressBar", {})
	#define_style("RichTextLabel", {})
	#define_style("ScrollContainer", {})
	#define_style("SpinBox", {})
	#define_style("SplitContainer", {})
	#define_style("TabBar", {})
	#define_style("TabContainer", {})
	#define_style("TextEdit", {})

	# Styling for default tooltip
	#define_style("TooltipLabel", {})
	#define_style("TooltipPanel", {})

	#define_style("Tree", {})
#endregion

#region Window Styles
	#define_style("AcceptDialog", {})
	#define_style("FileDialog", {})
	#define_style("PopupDialog", {})
	#define_style("PopupMenu", {})
	#define_style("PopupPanel", {})
	#define_style("Window", {})
#endregion

#region Template message (notifications) styling
	define_variant_style("MessagePanelContainer", "PanelContainer", {})
	define_variant_style("MessageLabel", "Label", {})
#endregion

#region Template remapping controls styling
	# Buttons used for remapping controls are styled to have just a border for hover and focus
	var sb_remap_button_focused: Dictionary = stylebox_flat(
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
