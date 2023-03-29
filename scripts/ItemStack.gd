class_name ItemStack extends Object

## The Item that the ItemStack contains. If this is null, the ItemStack is invalid.
@export var item: Item
## The amount of items in this ItemStack. If this is zero or less, the ItemStack is invalid.
@export_range(0, INF, 1) var size: int
## The amount of damage this item has taken. If this is greater than item.max_damage, the ItemStack is invalid.
@export var damage: int
## Additional custom data that the Item can store.
@export var data: Dictionary

## Validates the ItemStack. This ensures that the itemstack has an item, has a positive size and has a damage less than the item's max damage (if it is nonzero). If this is false, the size and damage are set to 0, the item is set to null, and data is set to an empty Dictionary.
func validate():
	if item == null:
		size = 0
		damage = 0
		data = {}
		return
	size = clamp(size, 0, item.max_size)
	if (damage >= item.max_damage and item.max_damage != 0) or size < 0:
		item = null
		validate()
		return

## Splits a certain number of items to another ItemStack.
func split(amount: int) -> ItemStack:
	amount = clamp(amount, 0, size)
	if amount == 0: return ItemStack.new(null, 0, 0, {})
	var stack = ItemStack.new(item, amount, damage, data)
	size -= amount
	validate()
	return stack

## Adds a certain number of items to the ItemStack, and returns the overflow.
func add(amount: int) -> int:
	size += amount
	var overflow = max(size - item.max_stack, 0)
	size -= overflow
	return overflow

func _init(item, size, damage, data):
	self.item = item
	self.size = size
	self.damage = damage
	self.data = data
