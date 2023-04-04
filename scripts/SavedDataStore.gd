## Stores all saved game data.
class_name SavedDataStore extends Resource

## The player's local ID.
@export var local_player_id: String

## The list of servers that the player has added.
@export var added_servers: Array[ServerInfo] = []

## The list of servers that the player has created. These are usually stored as separate files.
@export var hosted_servers: Array[ServerSavedData] = []

func prepare():
	if local_player_id == "":
		local_player_id = UUID.v4()
