extends CharacterBody2D
class_name Player

var states:Player_states = Player_states.new()
var animations:Player_animations = Player_animations.new()

@export_category("MOVEMENT")
@export var gravity_scale = 2
@export var speed = 500
@export var acceleration = 1500
@export var friction = 1500

@export_category("JUMP")
@export var jump_force = -900
@export var air_acceleration = 2000
@export var air_friction = 500
@onready var coyote_jump: Timer = $coyote_jump


func _ready() -> void:
	$Sprite2D/Sprite2D2.visible = false 

func _input(event: InputEvent) -> void:
	
	if Input.is_action_pressed("attack"):
		pass

func _physics_process(delta: float) -> void:
	var input_axis = Input.get_axis("left","right")
	
	apply_gravity(delta)
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	handle_jump()
	handle_air_acceleration(input_axis, delta)
	flip()
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >= 0 
	if just_left_edge:
		coyote_jump.start()

func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta 

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func handle_jump():
	if is_on_floor() or coyote_jump.time_left > 0:
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force
			coyote_jump.stop()
			
	elif not is_on_floor():
		if Input.is_action_just_pressed("jump") and velocity.y < jump_force / 2:
			velocity.y = jump_force / 2

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)

func flip():
	if velocity.x > 0.0:
		scale.x = scale.y * 1
	if velocity.x < 0.0:
		scale.x = scale.y * -1
		
