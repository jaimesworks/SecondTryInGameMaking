extends Weapon

@onready var area : Area3D = $Area #Reference to its parent area

func _physics_process(delta: float) -> void:
	area.scale = Vector3.ONE * stats_component.get_multiplier(StatsComponent.Stat.AREA)
	super(delta)

##Each time called aplies the damage to the enemies in it
func attack() -> bool:
	for enemy in area.get_overlapping_bodies():
		if enemy.is_in_group("enemy"):
			enemy.get_node("HealthComponent").take_damage(get_damage())
	return true
