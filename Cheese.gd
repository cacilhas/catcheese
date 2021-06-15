class_name Cheese
extends Area

signal gotit()

onready var animation := $Animation


func _ready() -> void:
	animation.current_animation = "rotation"


func _on_body_entered(_body: Node) -> void:
	emit_signal("gotit")
	call_deferred("queue_free")
