@tool
extends AnimationPlayer

@export var play = false
@export var affect = true

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		if affect:
			if play:
				get_parent().play = true
				add_to_group("anim")
			else:
				remove_from_group("anim")
				if get_tree().get_nodes_in_group("anim") == []:
					get_parent().play = false
		
