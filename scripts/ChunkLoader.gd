@tool
@icon("res://editor/icons/ChunkLoader.svg")
class_name ChunkLoader extends Node2D
var _manager: ChunkManager = null
@export var radius = 240:
	set(new_radius):
		radius = new_radius
		queue_redraw()

func _draw():
	if Engine.is_editor_hint():
		draw_circle(global_position, radius, Color(Color.DARK_RED, 0.5))

func _find_manager() -> ChunkManager:
	var p = get_parent()
	while p != null and not (p is ChunkManager):
		p = p.get_parent()
	return p

func _enter_tree():
	_manager = _find_manager()
	if _manager:
		_manager.loader_added.emit(self)

func _exit_tree():
	if _manager:
		_manager.loader_removed.emit(self)
		_manager = null

func _get_configuration_warnings():
	if _find_manager() == null:
		return ["A ChunkLoader must be inside a ChunkManager."]
