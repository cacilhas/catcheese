extends Spatial

export var Cheese: PackedScene
export var Danger: PackedScene
export var Settings: Script
onready var chop_audio := $Chop
onready var hud := $HUD
onready var player := $Player
onready var player_cam := $Player/Camera
onready var panorama_cam := $Panorama
var danger_track := {}

func _ready() -> void:
	var settings: Settings = Settings.new()
	settings.reload()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var lx = int(settings.size.x)
	var ly = int(settings.size.y)
	for _i in settings.cheeses:
		var x: int = randi() % lx - lx / 2
		var y: int = randi() % ly - ly / 2
		while x == 0 and y == 0:
			y = randi() % 10 - 5
		var cheese: Cheese = Cheese.instance()
		add_child(cheese)
		cheese.translate(Vector3(x * 2, 0, y * 2))
		cheese.connect("gotit", self, "_score")


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Start.tscn")

	if Input.is_action_pressed("ui_map"):
		player_cam.current = false
		panorama_cam.current = true
	else:
		panorama_cam.current = false
		player_cam.current = true


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


func _process(delta: float) -> void:
	panorama_cam.transform.origin.x = player.transform.origin.x
	panorama_cam.transform.origin.z = player.transform.origin.z
