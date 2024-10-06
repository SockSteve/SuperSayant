extends Area2D

@export var par: Node2D

func die():
	par.queue_free()
