extends Node2D

var collected_value: int = 0

func _ready() -> void:
	Events.collected.connect(increase_collected_value)
	Events.game_over.connect(end_game)
	Events.timeout.connect(end_game)
	

func end_game(game_won: bool):
	if collected_value < 250:
		Events.end_game.emit("LOST", collected_value)
		return
	
	if game_won:
		Events.end_game.emit("WON", collected_value)
		return
	else:
		Events.end_game.emit("LOST", collected_value)
		return


func increase_collected_value(value):
	collected_value += value
	Events.collected_amnt_changed.emit(collected_value)
