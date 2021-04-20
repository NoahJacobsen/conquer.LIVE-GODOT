extends Node2D

const CAMERA_SPEED = 100

var camera_bounds = Rect2(0,0,0,0)

func _physics_process(delta):
	move_camera(delta)

func _ready():
	print("Ready!")
	camera_bounds = self.get_parent().get_parent().camera_bounds
	print("Recieved bounds:", camera_bounds)
	$Camera2D.current = true

func move_camera(delta):
	var dir = Vector2(0,0)
	if (Input.is_action_just_pressed("camera_down")):
		dir += Vector2(0, CAMERA_SPEED)
	if (Input.is_action_just_pressed("camera_up")):
		dir += Vector2(0, -CAMERA_SPEED)
	if (Input.is_action_just_pressed("camera_right")):
		dir += Vector2(0, CAMERA_SPEED)
	if (Input.is_action_just_pressed("camera_left")):
		dir += Vector2(0, -CAMERA_SPEED)
		
	dir.normalized()
	
	var check_pos = position + dir
	if (camera_bounds.has_point(check_pos)):
		position += delta*dir
