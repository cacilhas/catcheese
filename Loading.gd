extends Node2D


func _on_timeout() -> void:
	get_tree().call_deferred("change_scene", "res://Main.tscn")
