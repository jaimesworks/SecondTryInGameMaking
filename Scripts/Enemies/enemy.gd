extends CharacterBody3D

var player : Node3D;

@export var xp_given := 10 ## The xp it gives when dies
@export var speed := 3.00 ## How fast it moves
@export var rotation_speed := 10.0 ## How fast the model rotates when changing directions
@export var xp_gem_scene : PackedScene ## The Scene of the XpGem it drops when dies


@onready var model : Node3D = $EnemyModel ##reference of its model
@onready var healthComponent : Node = $HealthComponent ##reference of its HealthComponent


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	healthComponent.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta;
	
	var path_to_player := player.global_position - global_position
	var direction := Vector3(path_to_player.x, 0, path_to_player.z).normalized()
	
	if direction != Vector3.ZERO:
		var to_look := atan2(-direction.x, -direction.z)
		model.rotation.y = lerp_angle(model.rotation.y, to_look, rotation_speed * delta)
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()

## Drops a XpGem where it died and removes it from the scene
func _on_died():
	print(self.name, " died")
	var gem := xp_gem_scene.instantiate()
	gem.value = xp_given
	gem.position = global_position
	get_tree().current_scene.add_child.call_deferred(gem)
	queue_free()
