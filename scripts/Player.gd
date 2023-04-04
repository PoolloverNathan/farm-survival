class_name Player extends CharacterBody2D
signal active_slot_changed(old_slot: int, new_slot: int)

const SPEED = 300.0
@export var inventory_data: InventoryData
@export var inventory: Inventory

@export_range(1, 4, 1) var selected_slot: int = 1:
	set(new_selected_slot):
		assert(new_selected_slot >= 1 && new_selected_slot <= 4, "selected_slot must be between 1 and 4.")
		if selected_slot != new_selected_slot:
			active_slot_changed.emit(selected_slot, new_selected_slot)
			inventory.get_slot(selected_slot)
			selected_slot = new_selected_slot

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if not inventory:
		pass
		#inventory = inventory_data.duplicate()

func _process(delta):
	var new_slot = selected_slot
	if Input.is_action_just_pressed("item_1"): new_slot = 1
	if Input.is_action_just_pressed("item_2"): new_slot = 2
	if Input.is_action_just_pressed("item_3"): new_slot = 3
	if Input.is_action_just_pressed("item_4"): new_slot = 4
	selected_slot = new_slot

func _physics_process(delta):
	if not multiplayer.multiplayer_peer or multiplayer.get_unique_id() == get_multiplayer_authority():
		var x = Input.get_axis("west", "east")  
		var y = Input.get_axis("north", "south")
		velocity = Vector2(x, y) * SPEED
	move_and_slide()
	if velocity.x:
		rotation = 0
		scale = Vector2(-1, 1) if sign(velocity.x) < 0 else Vector2(1, 1)
