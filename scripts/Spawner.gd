extends Node2D

var bounds: Rect2
var spawn_path: Path2D
var spawnables: Array[Spawnable]

func spawn() -> bool:
	if spawnables.is_empty(): return false
	var pos = spawn_path.curve.samplef(randf() * spawn_path.curve.point_count)
	var gpos = to_global(pos)
	if not bounds.has_point(gpos): return false
	var ray = RayCast2D.new()
	ray.target_position = pos
	add_child(ray)
	ray.force_raycast_update()
	ray.queue_free()
	if ray.is_colliding(): return false
	var sp = spawnables.pick_random()
	if sp == null: return false
	var scn: PackedScene = sp.scenes.pick_random()
	if scn == null: return false
	var inst: Node2D = scn.instantiate()
	inst.position = pos
	add_child(inst)
	return true
	#var node = (spawnable_scenes.pick_random() as PackedScene).instantiate()

class Spawnable extends Resource:
	@export var scenes: Array[PackedScene]
