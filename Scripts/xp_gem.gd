extends Area3D

@export var value := 1

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.get_node("ExperienceComponent").add_experience(value)
		queue_free()
