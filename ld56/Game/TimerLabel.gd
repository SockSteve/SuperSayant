extends Label

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	var time_left = floori(timer.time_left)
	text = str(time_left)

func _on_timer_timeout() -> void:
	Events.timeout.emit(true)
