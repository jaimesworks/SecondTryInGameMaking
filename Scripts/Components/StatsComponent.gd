extends Node
class_name StatsComponent

enum Stat { DAMAGE, ATTACK_SPEED, AREA, MOVE_SPEED}

var bonuses := {
	Stat.DAMAGE: 0.0,
	Stat.AREA: 0.0,
	Stat.ATTACK_SPEED: 0.0,
	Stat.MOVE_SPEED: 0.0,
	}

func add_bonus(stat: Stat, amount: float) -> void:
	bonuses[stat] += amount

func get_multiplier(stat: Stat) -> float:
	return (1+bonuses[stat])
