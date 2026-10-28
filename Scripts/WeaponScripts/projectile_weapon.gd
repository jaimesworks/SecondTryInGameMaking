extends Weapon

@export var bullet_scene : PackedScene
@export var weapon_range := 15.0

#bullet attributes
@export var speed := 15.00
@export var lifetime := 3.00

func attack() -> bool:
		var target := find_nearest_enemy()
		if target == null:
			return false
		var bullet := bullet_scene.instantiate()
		bullet.damage = get_damage()
		bullet.speed = speed
		bullet.lifetime = lifetime
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.direction = (target.global_position - bullet.global_position).normalized()
		return true

func find_nearest_enemy() -> Node3D:
	var nearest : Node3D = null
	var nearest_distance := weapon_range
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		var d : float = global_position.distance_to(enemy.global_position)
		if d < nearest_distance:
			nearest = enemy
			nearest_distance = d
	return nearest
