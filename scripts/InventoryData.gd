@tool
class_name InventoryData extends Resource

@export var size: int
#@export var slot_filters: Array[SlotFilter] = []

func _get_property_list():
	return [{
		"name": "slot_filters",
		"type": TYPE_ARRAY,
		"hint": PROPERTY_HINT_ARRAY_TYPE,
		"hint_string": "Inventory.SlotFilter",
		"usage": PROPERTY_USAGE_ARRAY | PROPERTY_USAGE_STORAGE | PROPERTY_USAGE_EDITOR,
	}]
