extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("ant"):
		body.die()

func recover():
	animation_player.play("Recover")

func stomp():
	animation_player.play("Stomp")
	
func emit_screen_shake():
	Events.shake_screen.emit(1)
