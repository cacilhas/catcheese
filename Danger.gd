extends Spatial

onready var animation := $Animation


func _ready():
	animation.current_animation = "pulse"
