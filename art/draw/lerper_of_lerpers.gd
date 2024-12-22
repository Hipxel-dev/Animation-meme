extends Node2D

@export var take_object_size_in_delay_calculation = false

@onready var children = get_children()
var count = 0

@export var active = false
@export var activation_speed = 0.1


func _physics_process(delta: float) -> void:
	if active:
		if count < children.size() :
			count += activation_speed
			
		if count > children.size():
			count = children.size()
			
		for i in range(floor(count)):
			children[i].activated = true
		
