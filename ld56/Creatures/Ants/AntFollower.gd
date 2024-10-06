extends CharacterBody2D

@export var speed = 1450

@onready var collectible: Sprite2D = $Collectible
var collectible_value: int = 0
@export var lead_ant: LeadAnt = null
@onready var timer: Timer = $Timer

@onready var collect_sfx: AudioStreamPlayer2D = $collect
@onready var drop: AudioStreamPlayer2D = $drop
@onready var timer_2: Timer = $Timer2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collect_ant: AudioStreamPlayer2D = $collectAnt



func _physics_process(delta: float) -> void:
	#var dir = to_local(nav_agent.get_next_path_position()).normalized()
	#velocity = dir * speed
	
	
	if lead_ant:
		var dir = (lead_ant.global_position - global_position).normalized()
		velocity = dir * speed
		look_at(lead_ant.global_position)
	move_and_slide()


func die():
	animation_player.play("die")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is LeadAnt:
		collect_ant.play()
		lead_ant = body
		timer.start()


func collect(item: Texture, value):
	collect_sfx.play()
	$Collectible.texture = item
	collectible_value = value


func drop_collectible() -> int:
	var collected_value: int = 0
	
	if collectible.texture:
		drop.play()
		collectible.texture = null
		collected_value = collectible_value 
		collectible_value = 0
		return collected_value
		
	return collected_value



func _on_idle_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ant"):
		set_physics_process(false)
		timer_2.start()


func _on_idle_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("ant"):
		set_physics_process(true)


func _on_timer_2_timeout() -> void:
	set_physics_process(true)
