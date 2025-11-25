extends CharacterBody2D


var speed = 0.0
var dash_speed = 20000.0
var dash = false
const JUMP_VELOCITY = -600.0
var activ = true
var stamina = 100

func _physics_process(delta: float) -> void:
	$UI/StaminaBar.value = stamina
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and activ:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("dash") and activ and stamina >= 50:
		$Timer.start()
		dash = true
		stamina -= 50
		
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction and activ:	
		if dash == true:
			
			velocity.x = direction * dash_speed
		else:	
			velocity.x = direction * speed 
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
		
	if dash == true:
			$AnimationPlayer.play("dash")
	elif not is_on_floor() :
		$AnimationPlayer.play("jump")
	else:
		if Input.is_action_pressed("ui_down"):
			$AnimationPlayer.play("slide")
		elif velocity.x != 0:
			$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("RESET")

	if direction == -1:
		transform.x = Vector2(-1.0,0.0)
	if direction == 1:
		transform.x = Vector2(1.0,0.0)
			
	if activ:
		$CollisionShape2D/Camera2D.enabled = true
		$UI/StaminaBar.visible = true
		speed = 1000
		
	else:
		$CollisionShape2D/Camera2D.enabled = false
		$UI/StaminaBar.visible = false
		speed = 200
		
	move_and_slide()


func _on_timer_timeout() -> void:
	dash = false
	pass # Replace with function body.
