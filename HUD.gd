extends Control

onready var time_label := $Time
onready var cheese_left_label := $CheeseLeft
onready var well_done_label := $WellDone
onready var best_time_label := $BestTime
var done := false
var best_time := 10000
var timer := 0.0
var cheese_left := 4
var storage := "user://data.json"


func _ready() -> void:
	read_storage()


func _process(delta: float) -> void:
	if not done:
		timer += delta
		time_label.text = "Time: %04d" % timer


func score() -> void:
	cheese_left -= 1
	cheese_left_label.text = "Cheese Left: %d" % cheese_left
	if cheese_left <= 0:
		done = true
		well_done_label.show()
		call_deferred("save_score")


func read_storage() -> void:
	var file := File.new()
	if file.file_exists(storage):
		file.open(storage, File.READ)
		var data := JSON.parse(file.get_as_text())
		if data.result and data.result.best_time:
			best_time = data.result.best_time
			best_time_label.text = "Best Time: %04d" % best_time
			best_time_label.show()
		file.close()


func save_score() -> void:
	if timer < best_time:
		var file := File.new()
		file.open(storage, File.WRITE)
		file.store_string(JSON.print({best_time = int(timer)}))
		file.close()
		read_storage()
