extends Node2D
var activ = 1

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("change"):
		activ += 1
		if activ > 3:
			activ = 1
			
	match activ:
		1:
			$"Player 1".activ = true
			$"Player 2".activ = false
			$"Player 3".activ = false
			
		2:
			$"Player 2".activ = true
			$"Player 1".activ = false
			$"Player 3".activ = false
			
		3: 
			$"Player 3".activ = true 
			$"Player 1".activ = false
			$"Player 2".activ = false
			
			
		
		
	#$"Player 1".posActiv = ($"Player 2".position.x - $"Player 1".position.x) / abs($"Player 2".position.x - $"Player 1".position.x)
	#$"Player 2".posActiv =($"Player 1".position.x - $"Player 2".position.x) / abs($"Player 1".position.x - $"Player 2".position.x)
