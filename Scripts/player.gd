extends CharacterBody3D
## Base speed of the player
@export var speed := 6.0
## Base jump heigh
@export var jump_velocity := 5.0 
## Mouse sensivity 
@export var mouse_sensivity := 0.003 
## How fast the model rotates when changing directions
@export var rotation_speed := 10.0 
## How many seconds the pj is invincible after a hit
@export var damage_cooldown := 0.5 

@onready var camera_pivot: Node3D = $CameraPivot ##reference to the camera's pivot (moves the camera in the Y axis)
@onready var spring_arm: SpringArm3D = $CameraPivot/SpringArm3D ##reference to the camera's SpringArm (moves the camera in the X axis)
@onready var model: Node3D = $model ##reference to de player's model
@onready var healthComponent: Node = $HealthComponent ##reference to the player's healthcomponent
@onready var hurtbox: Area3D = $Hurtbox ##reference to the player's hurtbox

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	spring_arm.add_excluded_object(get_rid())
	healthComponent.died.connect(_on_died)

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseMotion:
		camera_pivot.rotate_y(-event.relative.x * mouse_sensivity)
		spring_arm.rotate_x(-event.relative.y * mouse_sensivity)
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-70), deg_to_rad(20))
		
	if event.is_action("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("ui_accept"):
		var aimed_enemy = get_tree().get_first_node_in_group("enemy")
		if aimed_enemy == null:
			return
		

func _physics_process(delta: float) -> void:
	if damage_cooldown > 0:
		damage_cooldown -= delta
	if damage_cooldown <= 0:
		for body in hurtbox.get_overlapping_bodies():
			if body.is_in_group("enemy"):
				healthComponent.take_damage(10)
				damage_cooldown = 0.5
				break
	
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
	
	#direction
	var input_dir := Input.get_vector("move_left","move_right","move_forward","move_back")
	var direction := camera_pivot.global_basis * Vector3(input_dir.x, 0, input_dir.y).normalized()
	
	#rotate de model
	if direction != Vector3.ZERO:
		var to_look := atan2(-direction.x, -direction.z)
		model.rotation.y = lerp_angle(model.rotation.y, to_look, rotation_speed * delta)
	
	#apply horizontal speed
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()

## Errases the player and restarts the loop
func _on_died():
	print(self.name, " died")
	get_tree().reload_current_scene()

## Prints the current level when leveled up
func _on_experience_component_leveled_up(new_level: int) -> void:
	print("Leveled up!, new level: ",new_level)
