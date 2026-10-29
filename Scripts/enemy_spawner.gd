extends Node3D
class_name EnemySpawner

@export var enemy_pool: Array[PackedScene] ## List of what enemys can spawn
@export var spawn_cooldown := 1.5 ## Time in seconds between enemy spawns
var cooldown := 0.0 ## Current state of cooldown
@export var min_spawn_distance := 14.0 ## Minimum distance from the player where the enemies spawn
@export var max_spawn_distance := 15.0 ## Maximum distance from the player where the enemies spawn
@onready var player : Node3D = get_tree().get_first_node_in_group("player")## Reference of the player

func _physics_process(delta: float) -> void:

	if cooldown > 0:
		cooldown -= delta
	if cooldown <= 0:
		_spawn()
		cooldown = spawn_cooldown

## Instances a random enemy from the enemy_pool and puts it in the world in a random point between min_spawn_distance and max_spawn_distance
func _spawn() -> void :
	var enemy = enemy_pool.pick_random().instantiate()
	var random_angle := randf_range(0, TAU)
	var spawn_position : Vector3 = player.global_position + (Vector3(cos(random_angle), 0, sin(random_angle)) * (randf_range(min_spawn_distance, max_spawn_distance)))
	enemy.position = spawn_position
	get_tree().current_scene.add_child(enemy)
