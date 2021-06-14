extends Node2D

export var Settings: Script
onready var version := $Version


func _ready() -> void:
	var settings: Settings = Settings.new() # no need for reloading
	version.text = settings.version
