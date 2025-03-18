extends Sprite2D

##idk how to create enums, I have a deadline to meet
var careerselected = false
var syncalongselected = false
var helpselected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("botrow") or Input.is_action_pressed("midrow") or Input.is_action_pressed("toprow"):
		careerselected = false
		syncalongselected = false
		helpselected = false
	if Input.is_action_pressed("toprow"):
		Careerselected()
	if Input.is_action_pressed("botrow"):
		Helpselected()
	if Input.is_action_pressed("strum"):
		if careerselected:
			get_tree().change_scene_to_file("res://01/01_01.tscn")
		elif helpselected:
			get_tree().change_scene_to_file("res://01/helpscene.tscn")

func Careerselected () -> void:
	$/root/Node2D/menusprite.texture = load('res://Assets/Jpegs/Menu and Help/menu_career_select.png')
	careerselected = true
func Helpselected () -> void:
	$/root/Node2D/menusprite.texture = load('res://Assets/Jpegs/Menu and Help/menu_help_select.png')
	helpselected = true
