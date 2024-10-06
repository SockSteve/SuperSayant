extends CharacterBody2D
class_name LeadAnt

@export var speed = 2000
var click_pos: Vector2 = Vector2()
var target_pos: Vector2 = Vector2()

@onready var collectible: Sprite2D = $Collectible
var collectible_value: int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var collect_sfx: AudioStreamPlayer2D = $collect
@onready var drop: AudioStreamPlayer2D = $drop

var super_sayant: bool = false


func _ready() -> void:
	click_pos = position
	Events.say_ant_threshold_reached.connect(become_sayant)

func _physics_process(delta: float) -> void:
	
	#if Input.is_action_pressed("ui_up"):
		#velocity.y = -1 * speed 
	#if Input.is_action_pressed("ui_down"):
		#velocity.y = 1 * speed
	#if Input.is_action_pressed("ui_left"):
		#velocity.x = -1 * speed 
	#if Input.is_action_pressed("ui_right"):
		#velocity.x = 1 * speed 
	#
	#if not Input.is_anything_pressed():
		#velocity = Vector2.ZERO
	if Input.is_action_pressed("left_click"):
		click_pos = get_global_mouse_position()
	
	if position.distance_to(click_pos) > 10:
		target_pos =(click_pos - position).normalized()
		velocity = target_pos * speed
		move_and_slide()
	look_at(click_pos)

func become_sayant():
	if super_sayant:
		return
	super_sayant = true
	animation_player.play("become_sayant")

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


func die():
	animation_player.play("die")

func emit_game_over():
	Events.game_over.emit(false)

func _on_sayant_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		collect_sfx.play()
		Events.shake_screen.emit(1)
		Events.collected.emit(100)
		area.die()
