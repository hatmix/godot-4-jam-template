extends Node

# What goes into utils.gd?
# If the function is completely independent of the game, it's probably a utility.
# If not, it (probably) belongs in globals.gd


func reparent_node(node: Node, parent: Node, position_reset: bool = true) -> void:
	if not is_instance_valid(node):
		return
	var pos: Variant = node.get("global_position")

	var old_parent: Node = node.get_parent()
	if is_instance_valid(old_parent):
		old_parent.call_deferred("remove_child", node)
		await get_tree().process_frame
	if position_reset:
		node.set("position", Vector2.ZERO)
	if is_instance_valid(parent):
		parent.add_child(node)
	# Is the 2nd await required or could we set_deferred instead?
	# Or is no delay needed at all?
	# await get_tree().process_frame
	if position_reset and pos:
		node.set("global_position", pos)
