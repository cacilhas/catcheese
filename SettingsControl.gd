extends Control

export var Settings: Script

onready var intro := $Intro
onready var song := $Song
onready var fullscreen := $Fullscreen
onready var width := $Width
onready var height := $Height
onready var cheeses := $Cheeses
var settings: Settings


func _ready() -> void:
	settings = Settings.new()
	settings.reload()
	if OS.has_touchscreen_ui_hint():
		fullscreen.hide()
	else:
		fullscreen.pressed = settings.fullscreen
	width.value = settings.size.x
	height.value = settings.size.y
	cheeses.value = settings.cheeses


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		_exit()
	if Input.is_action_pressed("ui_accept"):
		_on_Save_pressed()


func _on_Save_pressed() -> void:
	settings.save()
	_exit()


func _exit() -> void:
	song.stop()
	get_tree().call_deferred("change_scene", "res://Start.tscn")


func _on_Fullscreen_pressed() -> void:
	settings.fullscreen = fullscreen.pressed
	OS.call_deferred("set_window_fullscreen", settings.fullscreen)


func _on_Width_changed(value: float) -> void:
	settings.size.x = int(value)


func _on_Height_changed(value: float) -> void:
	settings.size.y = int(value)


func _on_Cheeses_changed(value: float) -> void:
	settings.cheeses = int(value)


func _on_Intro_finished():
	song.play()
