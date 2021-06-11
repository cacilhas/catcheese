extends Spatial

export(PackedScene) var Cheese
onready var chop_audio := $Chop


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for _i in 4:
		var x: int = randi() % 10 - 5
		var y: int = randi() % 10 - 5
		while x == 0 and y == 0:
			y = randi() % 10 - 5
		var cheese: Cheese = Cheese.instance()
		add_child(cheese)
		cheese.translate(Vector3(x * 2, 0, y * 2))
		cheese.connect("gotit", self, "_score")


func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _score() -> void:
	if not chop_audio.playing:
		chop_audio.play()
