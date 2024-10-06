extends Camera2D

@export var shake_amount: float = 5.0
@export var shake_duration: float = 0.3

var shake_timer: float = 0.0
var is_shaking: bool = false
var shake_direction: int = 1


func _ready():
	Events.shake_screen.connect(shake_screen)


func _process(delta):
	if is_shaking:
		shake_timer -= delta
		if shake_timer <= 0:
			is_shaking = false
			offset = Vector2.ZERO
		else:
			offset.y = shake_amount * shake_direction / zoom.y
			shake_direction *= -1  # Alternate direction each frame

func shake(intensity: float = 1.0):
	is_shaking = true
	shake_timer = shake_duration
	shake_direction = 1
	shake_amount *= intensity

# Call this method to trigger the screen shake
func shake_screen(intensity):
	shake(intensity)
