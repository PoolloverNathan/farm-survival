class_name Item extends Resource
@export var texture: Texture2D
@export var name: String
@export_multiline var description: String
#@export var components: Array[ItemComponent]

class Notification:
	func cancel():
		self._cancelled = true
	func is_cancellable():
		return false
