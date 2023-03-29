class_name ItemComponent extends Resource

func _on_use(player: Player):
	pass

func _handle_notification(notification: Item.Notification):
	pass

class SceneItemComponent extends ItemComponent:
	func _get_scene():
		pass

class SeedComponent extends ItemComponent:
	pass
