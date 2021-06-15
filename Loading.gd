extends Node2D

export var Settings: Script

onready var background := $Background


func _ready() -> void:
	var settings: Settings = Settings.new()
	settings.reload()
	background.bg_color = settings.bg_color
	background.update()


func _on_timeout() -> void:
	get_tree().change_scene("res://Main.tscn")
