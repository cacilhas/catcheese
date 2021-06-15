extends Spatial

onready var animation := $Animation


func _ready() -> void:
	stop()


func walk() -> void:
	animation.current_animation = "walk"


func stop() -> void:
	animation.current_animation = "[stop]"
