extends Node
class_name StatsComponent

enum Stat { DAMAGE, ATTACK_SPEED, AREA, MOVE_SPEED}

var bonuses := {
	Stat.DAMAGE: 0.0,
	Stat.AREA: 0.0,
	Stat.ATTACK_SPEED: 0.0,
	Stat.MOVE_SPEED: 0.0,
	}

#DEBUJ, quitar
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_key"):
		var bonus := 0.2
		var stat_changed := Stat.ATTACK_SPEED
		add_bonus(stat_changed, bonus)
		print("Debug key pressed, changed:", stat_changed, "+", bonus)

func add_bonus(stat: Stat, amount: float) -> void:
	bonuses[stat] += amount

func get_multiplier(stat: Stat) -> float:
	return (1+bonuses[stat])
