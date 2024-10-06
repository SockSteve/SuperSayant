extends Node2D
@onready var norm: Marker2D = $norm
@onready var tar: Marker2D = $tar
var tar_reached: bool = false
@onready var sprite: Sprite2D = $Sprite
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var wander_direction: Node2D

var t = 0

func _physics_process(delta: float) -> void:
	
	if not tar_reached:
		t += delta * 0.4
	if tar_reached:
		t -= delta * 0.4
	t = clamp(t,0,1)
	sprite.position = norm.position.lerp(tar.position, t)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("ant"):
		body.die()



func _on_timer_timeout() -> void:
	audio_stream_player_2d.play()
	tar_reached = not tar_reached
