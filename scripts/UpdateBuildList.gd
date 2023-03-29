@tool
extends Control
@export var atlas: Texture2D
@export var interval: Rect2i
@export var count: Vector2i = Vector2i(0, 0)
@export var rect: Rect2i
@export var names: Array[String]
#enum BakeStatus {
#	Unbaked,
#	Baked,
#	ForceRebake
#}
#
#var _bake_status := BakeStatus.Unbaked
#@export var bake_status: BakeStatus:
#	set(new_bake_status):
#		if bake_status == _bake_status:
#			return
#		match new_bake_status:
#			BakeStatus.Unbaked:
#				clear_children()
#			_:
#				recalc()
#	get:
#		return _bake_status

@export var force_rebake = false:
	set(do_force_rebake):
		if do_force_rebake:
			recalc()

# Called when the node enters the scene tree.
func recalc():
	assert(atlas != null, "Please give an atlas.")
	assert(is_finite(count.x) and is_finite(count.y), "An infinite loop was narrowly avoided.")
	assert(count.x > 0 and count.y > 0, "count must be greater than 0 in both directions.")
	clear_children()
	var idx = 0
	for xi in count.x:
		var x = xi * interval.size.x + interval.position.x
		for yi in count.y:
			var y = yi * interval.size.y + interval.position.y
			var tr := TextureRect.new()
			var at := AtlasTexture.new()
			var rrect = Rect2(Vector2(x, y), interval.size)
			var region_key_prefix = "region_{x}_{y}_{w}_{h}_".format({ x = rrect.position.x, y = rrect.position.y, w = rrect.size.x, h = rrect.size.y })
			var region_name_key = region_key_prefix + "name"
			at.resource_name = names[idx] if len(names) > idx else atlas.get_meta(region_name_key) if atlas.has_meta(region_name_key) else (atlas.resource_name if atlas.resource_name else "Build") + str(idx)
			at.atlas = atlas
			at.region = Rect2(Vector2(rect.position) + Vector2(x, y), rect.size)
			tr.texture = at
			tr.name = at.resource_name
			add_child(tr)
			tr.owner = owner if owner else self
			idx += 1

func _enter_tree(): recalc()
func _exit_tree(): clear_children()

# Called when the node exits the scene tree.
func clear_children():
	for child in get_children():
		remove_child(child)
		child.queue_free()
