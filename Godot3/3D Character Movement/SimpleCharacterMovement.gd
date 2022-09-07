extends KinematicBody

export var base_speed = 12
export var speed_multiplier = 2
export var gravity = 70
export var jump_impulse = 25

var velocity = Vector3.ZERO

onready var spring_arm = $SpringArm

func _ready():
	add_to_group("player")

func is_jumping():  
	return velocity.y == 0

func _physics_process(delta):
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	input_vector = input_vector.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	var speed = base_speed * max(1, (speed_multiplier * Input.get_action_strength("sprint")))
	
	velocity.x = input_vector.x * speed
	velocity.z = input_vector.z * speed
	velocity.y -= gravity * delta
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		#AnimationPlayer.play("jump")
		velocity.y = jump_impulse
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if velocity.length() > 0.2:
		var look_direction = Vector2(velocity.z, velocity.x)

func _process(delta):
	spring_arm.translation = translation
