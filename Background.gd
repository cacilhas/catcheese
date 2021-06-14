extends Node2D

export var bg_color := Color.bisque


func _draw() -> void:
	var size := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, size), bg_color)
