extends Weapon
class_name ProjectileWeapon
##Weapon that shoots projectiles to the nearest enemy
@export var bullet_scene : PackedScene ##The bullet it spawns when shooting
@export var weapon_range := 15.0 ##The range the enemy needs to be in for the weapon to activate

@export_category("Bullet")
@export var speed := 15.00 ##How fast the bullet travels
@export var lifetime := 3.00 ##How much the bullet lasts in the world

## Spawns a bullet that travels to the nearest enemy if there is one and returns whether it spawned it or not
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

## Calculates the nearest enemy in the weapon range and it returns it, if there isnt one, returns null
func find_nearest_enemy() -> Node3D:
	var nearest : Node3D = null
	var nearest_distance := weapon_range
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		var d : float = global_position.distance_to(enemy.global_position)
		if d < nearest_distance:
			nearest = enemy
			nearest_distance = d
	return nearest
