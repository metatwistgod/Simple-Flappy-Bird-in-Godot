extends ColorRect

class_name Player

const GRAVITY = 1
const JUMP_FORST = -13
const SCREEN_HEIGHT := 600

var velocity := Vector2.ZERO

func move() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_FORST
	velocity.y += GRAVITY
	rect_position += velocity
	
	if rect_position.y < 0:
		rect_position.y = 0
	var __max_y = (SCREEN_HEIGHT - rect_size.y)

	if rect_position.y > __max_y:
		rect_position.y = __max_y
		
func _ready() -> void:
	rect_position.x = 20
	
#func _physics_process(delta: float) -> void:
##	move()
