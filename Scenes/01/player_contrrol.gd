extends CharacterBody2D
var curentVelocity = 200
var passscore = 2500
var score = 0
var inside = false
var intopRow = false
var inmidRow = false
var inbotRow = false
var correctplay = false
#mistakes are simply stronger than the correct marker
var mistake = false

func _physics_process(delta: float) -> void:
	#going right 'ere
	velocity.x = curentVelocity
	move_and_slide()
func _on_end_area_body_entered(body: Node2D) -> void:
	curentVelocity = 0
	if score> passscore:
		curentVelocity = 200
		$AnimatedSprite2D.visible = false
	else:
		get_tree().change_scene_to_file("res://01/fail.tscn")
	print(score)

func _on_end_area_2_body_entered(body: Node2D) -> void:
	curentVelocity = 40
	$AnimatedSprite2D.visible = true
	$/root/Node2D/Ezseszep/zene.play()

func _on_start_area_body_entered(body: Node2D) -> void:
	print("Entered")
	curentVelocity = 40
	$AnimatedSprite2D.visible = true
	$/root/Node2D/Zala/ZalaExternalPlayer.play()
func _on_top_row_body_entered(body: Node2D) -> void:
	intopRow = true
	print("EnteredTopRow")
func _on_top_row_body_exited(body: Node2D) -> void:
	intopRow = false
	print("ExitedTopRow")
func _on_mid_row_body_entered(body: Node2D) -> void:
	inmidRow = true
	print("EnteredMidRow")
func _on_mid_row_body_exited(body: Node2D) -> void:
	inmidRow = false
	print("ExitedMidRow")
func _on_bottom_row_body_entered(body: Node2D) -> void:
	inbotRow = true
	print("EnteredBotRow")
func _on_bottom_row_body_exited(body: Node2D) -> void:
	inbotRow = false
	print("ExitedBotRow")
func _process(delta: float) -> void:
	#firstly we check if the strumbar is engaged SHOULD IT BE
	if Input.is_action_pressed("strum"):
		#toprow logic
		if intopRow:
			if Input.is_action_pressed("toprow"):
				correctplay = true
				mistake = false
				print("Correct play detected top")
			else:
				correctplay = false
				mistake = true
				print("Mistake detected bot")
			#midrow logic
		if inmidRow:
			if Input.is_action_pressed("midrow"):
				correctplay = true
				mistake = false
				print("Correct play detected mid")
			else:
				correctplay = false
				mistake = true
				print("Mistake detected mid")
		#botrow logic
		if inbotRow:
			if Input.is_action_pressed("botrow"):
				correctplay = true
				mistake = false
				print("Correct play detected bot")
			else:
				correctplay = false
				mistake = true
				print("Mistake detected bot")
	calculateScore()
	if Input.is_action_just_released("strum"):
		$/root/Node2D/CharacterBody2D/TopEmitter.emitting = false
		$/root/Node2D/CharacterBody2D/MidEmitter.emitting = false
		$/root/Node2D/CharacterBody2D/BottomEmitter.emitting = false
		
	

	##reset the mistake/correctplay, if none of the conditions apply
	mistake = false
	correctplay = false
func calculateScore() -> void:
	if mistake == true:
		score -= 45
		$/root/Node2D/CharacterBody2D/TopEmitter.emitting = false
		$/root/Node2D/CharacterBody2D/MidEmitter.emitting = false
		$/root/Node2D/CharacterBody2D/BottomEmitter.emitting = false
	if mistake == false and correctplay == true:
		score += 50
		if intopRow:
			$/root/Node2D/CharacterBody2D/TopEmitter.emitting = true
		if inmidRow:
			$/root/Node2D/CharacterBody2D/MidEmitter.emitting = true
		if inbotRow:
			$/root/Node2D/CharacterBody2D/BottomEmitter.emitting = true
	else:
		score +=0
	print(score)
	
func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://01/menu.tscn")

func _on_scene_end_body_entered(body: Node2D) -> void:
	curentVelocity = 0 
	$/root/Node2D/SceneEnd/EndTimer.start() # Replace with function body.


func _on_endend_body_entered(body: Node2D) -> void:
	curentVelocity = 200
	$/root/Node2D/SceneEnd/ScoreDisplay.text = str( "Score: " , score)
	$AnimatedSprite2D.visible = false
