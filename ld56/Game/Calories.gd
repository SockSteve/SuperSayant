extends Label

@onready var progress_bar: ProgressBar = $ProgressBar
var default_text: String = "Calories %s"

func _ready() -> void:
	Events.collected_amnt_changed.connect(update_ui)
	update_ui()

func update_ui(value: int = 0):
	text = default_text % str(value)
	progress_bar.value = value
	if progress_bar.value >= progress_bar.max_value:
		Events.say_ant_threshold_reached.emit()
	
