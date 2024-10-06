extends Node2D

@onready var tongue_area: Area2D = $TongueArea
@onready var sprite: Sprite2D = $Sprite
@onready var tongue_timer: Timer = $TongueTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


var time:float = 0
var cooldown

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("ant"):
		body.die()


func _physics_process(delta: float) -> void:
	time += delta
	if time >= 4 and tongue_timer.is_stopped():
		audio_stream_player_2d.play()
		tongue_area.show()
		tongue_area.monitoring = true
		tongue_timer.start()
		
	

func _on_timer_timeout() -> void:
	time = 0
	tongue_area.hide()
	tongue_area.monitoring = false
