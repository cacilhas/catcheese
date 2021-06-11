extends Spatial


func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
