extends Area3D

var speed := 15.00 
var damage := 10.00
var lifetime := 3.00

var direction : Vector3

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	if lifetime > 0:
		lifetime -= delta
	if lifetime <= 0:
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		body.get_node("HealthComponent").take_damage(damage)
		queue_free()
