extends Control

export var Settings: Script

var _settings: Settings

onready var intro := $Intro
onready var song := $Song
onready var background := $Background
onready var bg_color_bt := $BackgroundColor
onready var fullscreen := $Fullscreen
onready var width := $Width
onready var height := $Height
onready var cheeses := $Cheeses


func _ready() -> void:
	_settings = Settings.new()
	_settings.reload()
	background.bg_color = _settings.bg_color
	background.update()
	if OS.has_touchscreen_ui_hint():
		fullscreen.hide()
	else:
		fullscreen.pressed = _settings.fullscreen
	width.value = _settings.size.x
	height.value = _settings.size.y
	cheeses.value = _settings.cheeses
	bg_color_bt.color = _settings.bg_color


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		_exit()
	if Input.is_action_pressed("ui_accept"):
		_on_Save_pressed()


func _on_Save_pressed() -> void:
	_settings.save()
	_exit()


func _exit() -> void:
	song.stop()
	get_tree().change_scene("res://Start.tscn")


func _on_Fullscreen_pressed() -> void:
	_settings.fullscreen = fullscreen.pressed
	OS.call_deferred("set_window_fullscreen", _settings.fullscreen)


func _on_Width_changed(value: float) -> void:
	_settings.size.x = int(value)


func _on_Height_changed(value: float) -> void:
	_settings.size.y = int(value)


func _on_Cheeses_changed(value: float) -> void:
	_settings.cheeses = int(value)


func _on_Intro_finished():
	song.play()


func _on_BackgroundColor_changed(color: Color) -> void:
	_settings.bg_color = color
	background.bg_color = color
	background.update()


func _on_Reset_pressed():
	_settings.reset()
	fullscreen.pressed = _settings.fullscreen
	OS.call_deferred("set_window_fullscreen", _settings.fullscreen)
	width.value = _settings.size.x
	height.value = _settings.size.y
	cheeses.value = _settings.cheeses
	bg_color_bt.color = _settings.bg_color
	background.bg_color = _settings.bg_color
	background.update()
