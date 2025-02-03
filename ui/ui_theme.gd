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
const BORDERS: int = 4
const OUTLINES: int = 8

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

var sb_panel = inherit(
	sb_round,
	{
		bg_color = BACKGROUND,
		border_ = border_width(BORDERS),
		border_color = OUTLINE,
	}
)

var sb_disabled_tab = stylebox_flat({bg_color = SHADOW})

var sb_selected_tab = stylebox_flat(
	{bg_color = PANEL, expand_margins_ = expand_margins(BORDERS, BORDERS, BORDERS, 8)}
)

var sb_unselected_tab = stylebox_flat(
	{bg_color = SHADOW, expand_margins_ = expand_margins(BORDERS, BORDERS, BORDERS, 7)}
)

var sb_hover_tab = stylebox_flat(
	{
		bg_color = SELECTED,
		expand_margins_ = expand_margins(BORDERS, BORDERS, BORDERS, 8),
	}
)

var sb_tab = inherit(
	sb_flat_bottom,
	{
		border_ = border_width(BORDERS * 2, 0, BORDERS * 2, 0),
		# Use transparent border to give tabs space
		border_color = Color("FFFFFF00"),
		expand_margins_ = expand_margins(BORDERS),
	}
)


# The project's default theme is set to res://ui/ui_theme.tres
func setup() -> void:
	set_save_path("res://ui/ui_theme.tres")


func define_theme() -> void:
	define_default_font(ResourceLoader.load("res://ui/assets/fonts/BlackHanSans-Regular.ttf"))
	define_default_font_size(16)

	define_style(
		"TabContainer",
		{
			font_disabled_color = SHADOW,
			font_hovered_color = TEXT,
			font_outline_color = OUTLINE,
			font_selected_color = TEXT,
			font_unselected_color = PANEL,
			outline_size = OUTLINES,
			side_margin = 24,
			panel = stylebox_empty({}),  #inherit(sb_panel, sb_round),
			tab_selected = inherit(sb_tab, sb_selected_tab),
			tab_unselected = inherit(sb_tab, sb_unselected_tab),
			tab_disabled = inherit(sb_tab, sb_disabled_tab),
			tab_focus = inherit(sb_tab, sb_hover_tab),
			tab_hovered = inherit(sb_tab, sb_hover_tab),
		}
	)

	# Replace the empty with stylebox_texture_panel, since theme_gen doesn't handle stylebox_texture
	define_style("Panel", {panel = stylebox_empty({})})
	define_style("ScrollContainer", {panel = stylebox_empty({})})

	define_style(
		"Label",
		{
			font_color = TEXT,
			outline_size = OUTLINES,
			font_outline_color = OUTLINE,
		}
	)

	define_style(
		"HSlider",
		{
			grabber = load("res://ui/assets/icons/bowler.png"),
			grabber_disabled = load("res://ui/assets/icons/bowler-disabled.png"),
			grabber_highlight = load("res://ui/assets/icons/bowler-selected.png"),
			center_grabber = 1,
			slider = stylebox_flat({ bg_color = SHADOW }),
			grabber_area = stylebox_flat({ bg_color = TEXT }),
			grabber_area_highlight = stylebox_flat({ bg_color = SELECTED }),
		}
	)

	define_style(
		"RichTextLabel",
		{
			default_color = TEXT,
			outline_size = OUTLINES,
			font_outline_color = OUTLINE,
			focus = stylebox_flat(
				{
					border_ = border_width(2),
					border_color = TEXT,
					corners_ = corner_radius(2),
					bg_color = Color.TRANSPARENT,
				},
			)
		}
	)

	define_style(
		"Button",
		{
			font_color = TEXT,
			font_focus_color = SELECTED,
			font_hover_color = SELECTED,
			font_hover_pressed_color = TEXT,
			font_pressed_color = TEXT,
			font_disabled_color = SHADOW,
			icon_normal_color = TEXT,
			icon_focus_color = PANEL,
			icon_hover_color = PANEL,
			icon_hover_pressed_color = TEXT,
			icon_pressed_color = TEXT,
			icon_disabled_color = SHADOW,
			outline_size = OUTLINES,
			font_outline_color = OUTLINE,
			normal = sb_button_normal,
			focus = sb_button_focus,
			hover = sb_button_hover,
			pressed = sb_button_pressed,
		}
	)
