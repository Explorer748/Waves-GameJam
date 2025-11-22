extends CharacterBody2D


var speed = 300.0
var dash_speed = 100
const JUMP_VELOCITY = -400.0
var activ = true
var stamina = 100

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and activ:
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and activ:
		velocity.x = direction * (speed + dash_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_just_pressed("dash") and activ and stamina >= 25:
		dash_speed = 10000
		stamina -= 25
	else:
		dash_speed = 0
		
	if activ:
		$CollisionShape2D/Camera2D.enabled = true
		speed = 300
		
	else:
		$CollisionShape2D/Camera2D.enabled = false
		speed = 200
		
	move_and_slide()
