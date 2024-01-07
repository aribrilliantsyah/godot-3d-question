extends Node

const MIN_X = -6.0
const MAX_X = 5.0
const MIN_Z = -13
const MAX_Z = 13
const Y = 0.524

const DF_P_X = -0.497
const DF_P_Y = 0
const DF_P_Z = 12.825

const DF_G_X = -2.516
const DF_G_Y = 0.524
const DF_G_Z = -8.701

@onready var option_yes = $OptionYes
@onready var option_no = $OptionNo
@onready var yes_result = $GUI/YesResult
@export var joystick_right : VirtualJoystick
@export var joystick_left : VirtualJoystick
@onready var player = $Player 
@onready var cam_player = $Player/Camera3D
@onready var button_restart = $GUI/Restart
@onready var button_jump = $GUI/Jump
@onready var button_hit = $GUI/Hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		player.global_transform.origin = Vector3(DF_P_X, DF_P_Y, DF_P_Z)
		option_no.global_transform.origin = Vector3(DF_G_X, DF_G_Y, DF_G_Z)
		
		yes_result.visible = false
		button_restart.visible = false
		button_jump.visible = true
		button_hit.visible = true
		joystick_right.visible = true
		joystick_left.visible = true
		
	if joystick_right and joystick_right.is_pressed:
		player.rotate_y(-joystick_right.output.x * .055)
		cam_player.rotate_x(-joystick_right.output.y * .055)
		cam_player.rotation.x = clamp(cam_player.rotation.x, -(PI/4), PI/4)

func _on_option_no_area_entered(_area):
	print("oh yeah")
	randomizePosition()

func _on_option_yes_area_entered(_area):
	yes_result.visible = true
	button_restart.visible = true
	button_jump.visible = false
	button_hit.visible = false
	button_hit.visible = false
	joystick_right.visible = false
	joystick_left.visible = false
	
func randomizePosition():
	var new_x = randf_range(MIN_X, MAX_X)
	var new_z = randf_range(MIN_Z, MAX_Z)
	var new_position = Vector3(new_x, Y, new_z)
	option_no.global_transform.origin = new_position


