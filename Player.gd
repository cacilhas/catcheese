extends KinematicBody

signal danger(pos)


export(float) var gravity := 98.0
onready var audio := $Audio
onready var head := $Head
var speed := 160.0
var spin := PI / 6


func _physics_process(delta: float) -> void:
	move_and_slide(process_input(delta), Vector3.UP)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.relative.x != 0:
		rotate_y(-lerp(0, spin / 2, event.relative.x / 10))

	if Input.is_action_just_pressed("ui_select"):
		emit_signal("danger", transform.origin)


func process_input(delta: float) -> Vector3:
	var velocity := Vector3.ZERO
	var play := false

	if Input.is_action_pressed("turn_left"):
		rotate_y(spin * 4 * delta)
	if Input.is_action_pressed("turn_right"):
		rotate_y(-spin * 4 * delta)

	if Input.is_action_pressed("ui_left"):
		play = true
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("ui_right"):
		play = true
		velocity -= transform.basis.x * speed
	if Input.is_action_pressed("ui_up"):
		play = true
		velocity += transform.basis.z * speed
		play = true
	if Input.is_action_pressed("ui_down"):
		velocity -= transform.basis.z * speed

	if play and not audio.playing:
		audio.play()
	if not play:
		audio.stop()
	if play:
		head.walk()
	else:
		head.stop()
	velocity.y = -gravity
	return velocity * delta
