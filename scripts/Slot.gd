class_name Slot extends PanelContainer

@export_range(0, INF, 1) var id: int = 0
@export var player: Player:
	set(new_player):
		if player: _disconnect_listeners(player)
		if new_player: _connect_listeners(new_player)
		player = new_player

func _disconnect_listeners(player: Player):
	player.inventory.slot_changed.disconnect(_slot_changed)
func _connect_listeners(player: Player):
	player.inventory.slot_changed.connect(_slot_changed)


@onready var rect = Item
func _slot_changed(id: int, _old: ItemStack, new_stack: ItemStack):
	if id == self.id:
		if new_stack && new_stack.size > 0:
			rect.visible = true
			rect.texture = new_stack.item.texture
		else:
			rect.visible = false
func _selected_changed(_old: int, new: int):
	theme_type_variation = "slot_selected" if new == id else "slot"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
