extends KinematicBody

signal danger(pos)

export var gravity: float
export var speed: float

var _spin := PI / 6

onready var audio := $Audio
onready var head := $Head


func _physics_process(delta: float) -> void:
	move_and_slide(process_input(delta), Vector3.UP)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.relative.x != 0:
		rotate_y(-lerp(0, _spin / 2, event.relative.x / 10))

	if Input.is_action_just_pressed("ui_select"):
		emit_signal("danger", transform.origin)


func process_input(delta: float) -> Vector3:
	var velocity := Vector3.ZERO
	var play := false

	if Input.is_action_pressed("turn_left"):
		rotate_y(_spin * 4 * delta)
	if Input.is_action_pressed("turn_right"):
		rotate_y(-_spin * 4 * delta)

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
