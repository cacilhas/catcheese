extends Control

export var Settings: Script

onready var time_label := $Time
onready var cheese_left_label := $CheeseLeft
onready var well_done_label := $WellDone
onready var best_time_label := $BestTime
var done := false
var timer := 0.0
var cheese_left: int
var settings: Settings


func _ready() -> void:
	settings = Settings.new()
	settings.reload()
	cheese_left = settings.cheeses
	cheese_left_label.text = "Cheese Left: %d" % cheese_left
	if settings.best_time > 0:
		best_time_label.text = "Best Time: %04d" % settings.best_time
		best_time_label.show()


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



func save_score() -> void:
	if settings.best_time == 0 or timer < settings.best_time:
		settings.best_time = int(timer)
		settings.save()
