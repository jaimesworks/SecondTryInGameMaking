extends Node
class_name ExperienceComponent
#Stores the level and experience of its parent
var actual_xp := 0.0 ## The current xp stored
var actual_level := 0 ## The actual level
var xp_for_next_lvl := 10.0 ## The xp required for the next level

## Signal executed when the player levels up
signal leveled_up(new_level: int)

## Adds experience to the player
func add_experience(amount: float) -> void:
	actual_xp += amount
	while actual_xp >= xp_for_next_lvl:
		actual_xp = actual_xp - xp_for_next_lvl
		actual_level += 1
		xp_for_next_lvl = xp_for_next_lvl*1.20
		leveled_up.emit(actual_level)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_key"):
		add_experience(9000000000000)
