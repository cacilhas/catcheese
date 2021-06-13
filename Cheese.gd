extends Area

class_name Cheese

signal gotit()

onready var animation := $Animation


func _ready() -> void:
	animation.current_animation = "rotation"


func _on_body_entered(_body: Node) -> void:
	emit_signal("gotit")
	queue_free()
