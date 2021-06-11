extends Control

onready var time_label := $Time
onready var cheese_left_label := $CheeseLeft
onready var well_done_label := $WellDone
var done := false
var timer := 0.0
var cheese_left := 4


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
