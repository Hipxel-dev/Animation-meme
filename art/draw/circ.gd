@tool
extends Node2D

@export var radius = 32
@export var start_angle = -PI
@export var end_angle = PI
@export var point_count = 360
@export var color = Color.WHITE
@export var width = 8

@export var spin_rand = 0.0
var spin = 0

func _ready() -> void:
	spin = randf_range(-spin_rand, spin_rand)
	
	
func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, start_angle, end_angle, point_count, color, width)
	
func _physics_process(delta: float) -> void:
	queue_redraw()
	
	rotation_degrees += spin
