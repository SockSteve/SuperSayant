extends Area2D

@export var value: int = 100
@onready var sprite: Sprite2D = $Sprite

func _on_body_entered(ant: Node2D) -> void:
	if not ant.is_in_group("ant"):
		return
	
	if ant.collectible.texture:
		return
	
	ant.collect(sprite.texture, value)
	queue_free()
