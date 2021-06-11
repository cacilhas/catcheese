extends Node2D

onready var start_button := $StartButton


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_accept"):
		_on_StartButton_pressed()


func _on_StartButton_pressed() -> void:
	start_button.hide()
	get_tree().change_scene("res://Main.tscn")
