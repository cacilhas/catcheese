extends Spatial

export(PackedScene) var Cheese
export(PackedScene) var Danger
onready var chop_audio := $Chop
onready var hud := $HUD
var danger_track := {}

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


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Start.tscn")


func _score() -> void:
	if not chop_audio.playing:
		chop_audio.play()
	hud.score()


func _on_danger(pos: Vector3) -> void:
	pos = Vector3(round(pos.x / 2) * 2, 0, round(pos.z / 2) * 2)
	var cur = danger_track.get(pos)
	if cur:
		cur.queue_free()
		danger_track.erase(pos)
	else:
		cur = Danger.instance()
		add_child(cur)
		cur.translate(pos)
		danger_track[pos] = cur
