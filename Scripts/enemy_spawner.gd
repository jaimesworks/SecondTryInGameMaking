extends Node3D
class_name EnemySpawner

@export var enemy_pool: Array[PackedScene] ## List of what enemys can spawn
@export var spawn_cooldown := 1.5 ## Time in seconds between enemy spawns
var current_spawn_cooldown := 0.0 ## Current state of spawn_cooldown
@export var min_spawn_distance := 14.0 ## Minimum distance from the player where the enemies spawn
@export var max_spawn_distance := 15.0 ## Maximum distance from the player where the enemies spawn
@onready var player : Node3D = get_tree().get_first_node_in_group("player")## Reference of the player
@export var difficulty_spawn_scaling:= 0.1 ## How much the difficulty_level affects the spawn of enmies
@export var difficulty_health_scaling:= 1.5 ## How much the difficulty_level affects the hp of enmies
@export var difficulty_cooldown := 30.0 ## Time in seconds between difficulty leveled up
var current_difficulty_cooldown ## Current state of difficulty_cooldown
var difficulty_level := 0.0 ## Current difficulty level
var difficulty_bonus := 1.0 ## Cuantity of how much difficulty_level increases each level up

func _ready() -> void:
	current_difficulty_cooldown = difficulty_cooldown

func _physics_process(delta: float) -> void:

	if current_spawn_cooldown > 0:
		current_spawn_cooldown -= delta
	if current_spawn_cooldown <= 0:
		_spawn()
		var divisor := 1 + difficulty_level * difficulty_spawn_scaling
		current_spawn_cooldown = spawn_cooldown/max(divisor, 0.1)
	
	if current_difficulty_cooldown > 0:
		current_difficulty_cooldown -= delta
	if current_difficulty_cooldown <= 0:
		difficulty_level += difficulty_bonus
		current_difficulty_cooldown = difficulty_cooldown

## Instances a random enemy from the enemy_pool and puts it in the world in a random point between min_spawn_distance and max_spawn_distance
func _spawn() -> void :
	var enemy = enemy_pool.pick_random().instantiate()
	#first calculate where it will spawn
	var random_angle := randf_range(0, TAU)
	var spawn_position : Vector3 = player.global_position + (Vector3(cos(random_angle), 0, sin(random_angle)) * (randf_range(min_spawn_distance, max_spawn_distance)))
	enemy.position = spawn_position
	#second calculate his stats
	var enemy_health_component : HealthComponent = enemy.get_node("HealthComponent")
	enemy_health_component.max_hp = max(enemy_health_component.max_hp+(difficulty_level*difficulty_health_scaling), 1)
	get_tree().current_scene.add_child(enemy)
