extends Area2D


func _on_body_entered(ant: Node2D) -> void:
	if not ant.is_in_group("ant"):
		return
	
	if not ant.collectible.texture:
		return
	
	var value = ant.drop_collectible()
	Events.collected.emit(value)
