extends Node

const SCREEN_WIDTH := 1024
const SCREEN_HEIGHT := 600
const PLAYER_SIZE := Vector2(64, 64)
const WALL_WIDTH := 64
const WALL_SPEED := -10
const HOLE_SIZE := 200

var background := ColorRect.new()
var player := Player.new()
var top_wall := Wall.new()
var bottom_wall := Wall.new()
var walls = [top_wall, bottom_wall]

func initialize_walls() -> void:
	for _i in walls.size():
		var __wall : Wall = walls[_i]
		__wall.rect_size.x = WALL_WIDTH
		__wall.rect_position.x = WALL_SPEED + (WALL_WIDTH * 15)

func is_colliding() -> bool:
	var __is_colliding := false
	for __i in walls.size():
		var __wall : Wall = walls[__i]
		var __player_rect := player.get_rect()
		var __wall_rect := __wall.get_rect()
		if __player_rect.intersects(__wall_rect):
			__is_colliding = true
			break
	return __is_colliding

func move_walls () -> void:
	var __position_reset := false
	for __i in walls.size():
		var __wall : Wall = walls[__i]
		if __wall.rect_position.x <= -WALL_WIDTH:
			__wall.rect_position.x = SCREEN_WIDTH + WALL_WIDTH
			__position_reset = true
		else:
			__wall.rect_position.x += WALL_SPEED
	if __position_reset:
		change_hole_pos()

func change_hole_pos() -> void:
	randomize()
	var __hole_y_top := randi() % (SCREEN_HEIGHT - HOLE_SIZE + 1)
	var __hole_y_bottom := __hole_y_top + HOLE_SIZE
	top_wall.rect_size.y = __hole_y_top
	bottom_wall.rect_position.y = __hole_y_bottom
	bottom_wall.rect_size.y = (SCREEN_HEIGHT + __hole_y_bottom)
	

	

func _ready() -> void:
	print_tree_pretty()
	initialize_walls()
	change_hole_pos()
	background.rect_size.x = SCREEN_WIDTH
	background.rect_size.y = SCREEN_HEIGHT
	background.color = Color.black
	player.rect_size = PLAYER_SIZE
	add_child(background)
	add_child(player)
	add_child(top_wall)
	add_child(bottom_wall)
	print_tree_pretty()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("Restart"):
		get_tree().reload_current_scene()

	
func _physics_process(delta: float) -> void:
	move_walls()
	player.move()
	
	if is_colliding():
		set_physics_process(false)

