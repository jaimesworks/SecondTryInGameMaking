extends Node3D
class_name Weapon

@export var damage := 10.0
@export var cooldown_time := 1.0
var cooldown := 0.0

@onready var stats_component : StatsComponent = get_parent().get_node("StatsComponent")

func _physics_process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta
	if cooldown <= 0:
		if attack() == true:
			cooldown = cooldown_time/stats_component.get_multiplier(StatsComponent.Stat.ATTACK_SPEED)

func get_damage() -> float:
	return (damage * stats_component.get_multiplier(StatsComponent.Stat.DAMAGE))

func attack() -> bool:
	return false
