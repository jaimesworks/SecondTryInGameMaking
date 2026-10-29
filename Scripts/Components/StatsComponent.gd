extends Node
class_name StatsComponent
## Stores the type of stats the parent can have and its bonuses
enum Stat { DAMAGE, ATTACK_SPEED, AREA, MOVE_SPEED} ## The stat types it has

## The actual bonuses of each Stat type
var bonuses := {
	Stat.DAMAGE: 0.0,
	Stat.AREA: 0.0,
	Stat.ATTACK_SPEED: 0.0,
	Stat.MOVE_SPEED: 0.0,
	} 

## Adds [param amount] to the bonus of the [param stat]
func add_bonus(stat: Stat, amount: float) -> void:
	bonuses[stat] += amount

## Returns the current multiplier of [param stat]
func get_multiplier(stat: Stat) -> float:
	return (1+bonuses[stat])
