@tool
@icon("res://editor/icons/ChunkManager.svg")
class_name ChunkManager extends Node2D
signal loader_added(loader: ChunkLoader)
signal loader_removed(loader: ChunkLoader)
var loaders: Array[ChunkLoader] = []
var chunk_size: Vector2 = Vector2(512, 512):
	set(new_chunk_size):
		chunk_size = new_chunk_size
		queue_redraw()

func _draw():
	if Engine.is_editor_hint():
		draw_rect(Rect2(global_position, global_scale * chunk_size), Color(Color.ORANGE, 0.1))

func get_translated_chunk(position: Vector2):
	var in_chunk_pos = Vector2(fposmod(position.x, chunk_size.x), fposmod(position.y, chunk_size.y))
	var chunk_loc = position / chunk_size

func _init():
	loader_added.connect(_loader_added)
	loader_removed.connect(_loader_removed)

func _loader_added(loader: ChunkLoader):
	loaders.push_back(loader)
func _loader_removed(loader: ChunkLoader):
	loaders.erase(loader)


