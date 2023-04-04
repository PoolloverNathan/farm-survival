@tool
extends Node2D
@export var lantern: GradientTexture2D

enum DayTime {
	DAY,
	NIGHT,
	NIGHT_SCARY
}
@export var day_time = DayTime.DAY
@onready var day_timer := $DayTimer

@export var lantern_near_color: Color:
	set(new_lantern_near_color):
		lantern.gradient.set_color(0, new_lantern_near_color)
	get:
		return lantern.gradient.get_color(0)
@export var lantern_mid_color: Color:
	set(new_lantern_mid_color):
		lantern.gradient.set_color(1, new_lantern_mid_color)
	get:
		return lantern.gradient.get_color(1)
@export var lantern_far_color: Color:
	set(new_lantern_far_color):
		lantern.gradient.set_color(2, new_lantern_far_color)
	get:
		return lantern.gradient.get_color(2)

func _ready():
	if not Engine.is_editor_hint():
		add_child(preload("res://player.tscn"))
