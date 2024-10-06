extends TextureRect

@onready var game_massage: Label = $VBoxContainer/GameMassage
@onready var game_score: Label = $VBoxContainer/GameScore

func _ready() -> void:
	Events.end_game.connect(show_and_update)


func show_and_update(massage: String, score: int):
	get_tree().paused = true
	game_massage.text = game_massage.text % massage
	game_score.text = game_score.text % str(score)
	show()
	
	

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
