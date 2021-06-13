extends Node2D

export var Settings: Script
onready var audio := $Audio
onready var start_button := $StartButton


func _ready() -> void:
	var settings: Settings = Settings.new()
	settings.reload()
	OS.window_fullscreen = settings.fullscreen or OS.has_touchscreen_ui_hint()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_select"):
		_on_StartButton_pressed()


func _on_StartButton_pressed() -> void:
	start_button.hide()
	audio.stop()
	get_tree().call_deferred("change_scene", "res://Main.tscn")


func _on_ChangeConfig_pressed():
	audio.stop()
	get_tree().call_deferred("change_scene", "res://SettingsControl.tscn")
