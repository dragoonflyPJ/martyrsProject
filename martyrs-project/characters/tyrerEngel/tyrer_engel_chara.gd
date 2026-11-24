extends CharacterBody2D

@export var maxspeed = 400
@export var accel = 1500
@export var friction = 600

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("walk_right")) - int(Input.is_action_pressed("walk_left"))
	input.y = int(Input.is_action_pressed("walk_down")) - int(Input.is_action_pressed("walk_up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()

	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized()*(friction*delta)
		else: velocity = Vector2.ZERO
	else:
		velocity += (input*accel*delta)
		velocity = velocity.limit_length(maxspeed)

	move_and_slide()

