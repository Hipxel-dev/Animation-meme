@tool
extends Node2D

@export var play = false
@export var affect = true

func _physics_process(delta: float) -> void:
	if affect:
		if Engine.is_editor_hint():
			if play:
				$AnimationPlayer.play("anim")
				$AnimationPlayer2.play("anim")
				$AnimationPlayer3.play("anim")
				$AnimationPlayer4.play("anim")
				$AnimationPlayer5.play("anim")
			else:
				$AnimationPlayer.stop()
				$AnimationPlayer2.stop()
				$AnimationPlayer3.stop()
				$AnimationPlayer4.stop()
				$AnimationPlayer5.stop()
			
			
