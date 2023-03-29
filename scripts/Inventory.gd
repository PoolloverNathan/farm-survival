@tool
class_name Inventory extends Resource
@export var data: InventoryData
var _items: Array[Item]
var _sizes: Array[int]
var _damages: Array[int]
var _datas: Array[Dictionary]
func _init(data: InventoryData):
	self.data = data
var info: Array:
	get:
		return [_items, _sizes, _damages, _datas]
	set(new_info):
		_items = new_info[0]
		_sizes = new_info[1]
		_damages = new_info[2]
		_datas = new_info[3]
signal slot_changed(id: int, old_stack: ItemStack, new_stack: ItemStack)

func _get_property_list():
	var props = super()
	props.append({
		"name": "info",
		"type": TYPE_ARRAY,
		"usage": PROPERTY_USAGE_STORAGE
	})
	return props

func get_slot(id: int) -> ItemStack:
	_check_size(id)
	return ItemStack.new(_items[id], _sizes[id], _damages[id], _datas[id].duplicate())

func set_slot(id: int, stack: ItemStack):
	_check_size(id)
	_items[id] = stack.item
	_sizes[id] = stack.size
	_damages[id] = stack.damage
	_datas[id] = stack.data.duplicate()

func _check_size(id: int):
	assert(id < data.size, "Slot id {} out of bounds for an inventory of size {}.".format([id, data.size]))
	if len(_items) < id: _items.resize(id)
	if len(_sizes) < id: _sizes.resize(id)
	if len(_damages) < id: _damages.resize(id)
	if len(_datas) < id: _datas.resize(id)

class SlotFilter extends Resource:
	@export var slots: Array[int]
