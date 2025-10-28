extends Node

# What goes into utils.gd?
# If the function is completely independent of the game, it's probably a utility.
# If not, it (probably) belongs in globals.gd

## Takes a Rect2 and returns the Vector2 offset needed to position it fully inside
## the visible viewport. Good for things that need to be positioned relative to
## a game object while remaining fully visible.
func nudge_inside_viewport(item_rect: Rect2) -> Vector2:
	var vp_rect: Rect2 = get_tree().current_scene.get_viewport().get_visible_rect()
	if vp_rect.encloses(item_rect):
		return Vector2.ZERO
	var merged: Rect2 = vp_rect.merge(item_rect)
	var offset: Vector2 = (vp_rect.get_center() - merged.get_center()) * 2
	return offset
