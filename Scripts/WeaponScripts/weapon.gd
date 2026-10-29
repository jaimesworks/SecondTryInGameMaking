extends Node3D
class_name Weapon
## Base class for all the weapons, it handles the cooldown and the stats; each weapon only implements attack().”
@export var damage := 10.0 ## Base damage
@export var cooldown_time := 1.0 ## Base seconds between attacks
var cooldown := 0.0 

@onready var stats_component : StatsComponent = get_parent().get_node("StatsComponent")

func _physics_process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta
	if cooldown <= 0:
		if attack():
			cooldown = cooldown_time/stats_component.get_multiplier(StatsComponent.Stat.ATTACK_SPEED)

## Returns the damage calculated with the base damage multiplied by the damage stat multiplier
func get_damage() -> float:
	return (damage * stats_component.get_multiplier(StatsComponent.Stat.DAMAGE))

## Base attack function called each time cooldown is 0
func attack() -> bool:
	return false
