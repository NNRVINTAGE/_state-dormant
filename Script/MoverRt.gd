extends Node3D

# much of the naming here are self explanatory, figure out yourself if you forgot future me
@export var move_speed: float = 2.6
@export var rotate_speed: float = 25.0
var set_ops: Vector3
var origin_position: Vector3
var origin_rotation: Vector3
var start_position: Vector3
var target_position: Vector3
var target_rotation: Vector3
var moving: bool = false
var rotating: bool = false
var direction: int = 1

func _ready():
	set_ops = transform.origin
	origin_position = set_ops
	origin_rotation = rotation_degrees
	target_rotation = rotation_degrees

func _physics_process(delta: float) -> void:
	var distance_to_move = move_speed * delta
	var rotation_delta = rotate_speed * delta
	if moving or rotating:
		if moving:
			var direction_vector = (target_position - transform.origin).normalized()
			if direction_vector.is_normalized() and direction_vector.is_finite():
				transform.origin += direction_vector * distance_to_move

			if transform.origin.distance_to(target_position) <= distance_to_move:
				transform.origin = target_position
				moving = false
		
		if rotating:
			var current_rot = rotation_degrees
			var target_rot = target_rotation
			var rotation_difference = target_rot - current_rot
			#to just avoid rotating more than 180 degrees
			for i in range(3):
				if abs(rotation_difference[i]) > 180:
					if rotation_difference[i] > 0:
						rotation_difference[i] -= 360
					else:
						rotation_difference[i] += 360

			# this add fixed rotation increment for each of tge axis based on rotate_speed, and snapping when close to target
			for i in range(3):
				rotation_degrees[i] += rotation_difference[i] * rotation_delta / abs(rotation_difference[i])
				if abs(rotation_difference[i]) <= rotation_delta:
					rotation_degrees[i] = target_rotation[i]

			# snap the rotatios when closw to target
			if rotation_difference.length() <= rotation_delta:
				rotation_degrees = target_rotation
				rotating = false

# idk what better naming for the function
func targetTransform(new_target_position: Vector3, new_target_rotation: Vector3) -> void:
	if moving or rotating:
		return
	
	if target_position == start_position:
		target_position = new_target_position
		target_rotation = new_target_rotation
		direction = 1
	else:
		start_position = transform.origin
		target_position = origin_position
		target_rotation = origin_rotation
		direction = 1
	
	moving = true
	rotating = true

# todos: remember what i forgot to fix, currently nothing bad happen. wish future me goodluck
