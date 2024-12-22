extends Node2D

var original_position = []
var things = []
var count = 0

@export var activated = false
@export var lerp_direction = Vector2(-3,0)
@export var lerp_mult_min = 0
@export var lerp_mult_max = 2

@export var falloff = false

var velocity = []
var movement_push = []

@export var cycle_thru_push = true
@export var count_strength = 0.5
@export var blink_color_1 = Color.WHITE
@export var blink_color_2 = Color.BLACK

@export var blink_distance = 640

var original_rotation = []
@export var spin = false

@export var lerp_strength = 0.1
@export var push_direction = Vector2.ZERO

@export var starting_scale = false
@export var spin_push = 0

@export var random_pos = false
@export var size_x_scale = false

func _ready() -> void:
	things = get_children()
	for i in range(things.size()):
		original_position.append(things[i].position)
		if not cycle_thru_push:
			things[i].position += lerp_direction * randf_range(lerp_mult_min,lerp_mult_max)
			movement_push.append(lerp_direction * randf_range(lerp_mult_min, lerp_mult_max))
		else:
			things[i].position += lerp_direction * lerp_mult_max * i
			movement_push.append(lerp_direction * lerp_mult_max * i)
		velocity.append(Vector2.ZERO)
		
		if spin:
			original_rotation.append(things[i].rotation_degrees * i)
			
			#things[i].rotation_degrees += 100 * sin(i * 2)
		
		if starting_scale:
			things[i].scale = Vector2.ZERO
			
		if random_pos:
			#things[i].position += Vector2(randf_range(-0,0),randf_range(-50,50))
			things[i].position += Vector2(randf_range(-lerp_direction.length(), lerp_direction.length()), randf_range(-lerp_direction.length(), lerp_direction.length()))
		
		if size_x_scale:
			things[i].scale.y = 0
			
func _physics_process(delta: float) -> void:
	if get_parent().visible:
		if activated and not falloff:
			if count < things.size():
				count += count_strength
			if count > things.size():
				count = things.size()
			for i in range(floor(count)):
				if starting_scale:
					things[i].scale += (Vector2.ONE - things[i].scale) * lerp_strength
				if spin:
					original_rotation[i] -= spin_push * i
					things[i].rotation_degrees += (original_rotation[i] - things[i].rotation_degrees) * lerp_strength
				original_position[i] += push_direction * (1 + i * 0.1)
				if things[i].position.distance_squared_to(original_position[i]) > blink_distance:
					things[i].modulate = Color(blink_color_1.r,blink_color_1.g,blink_color_1.b,sin(Time.get_ticks_msec() * delta * 8) * 1)
				else:
					things[i].modulate = blink_color_1
					
				things[i].position += (original_position[i] - things[i].position) * lerp_strength
				if size_x_scale:
					things[i].scale.y += (1 - things[i].scale.y) * lerp_strength
				
		elif falloff:
			if count < things.size() * 2:
				count += count_strength
			if count > things.size() * 2:
				count = things.size() * 2
			for i in range(floor(count - things.size())):
				things[i].position += velocity[i] * delta 
				velocity[i] += ((original_position[i] * lerp_direction) - things[i].position) * 0.001
				velocity[i] *= 1.05
				if things[i].position.distance_squared_to(original_position[i]) > blink_distance:
					things[i].modulate = Color(1,1,1,sin(Time.get_ticks_msec() * delta * 8) * 1)
			
			#velocity[i] /= 1.1
	
