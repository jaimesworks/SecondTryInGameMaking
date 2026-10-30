extends Node
class_name ExperienceComponent
#Stores the level and experience of its parent
var current_xp := 0.0 ## The current xp stored
var current_level := 0 ## The current level
var xp_for_next_lvl := 10.0 ## The xp required for the next level

## Signal executed when the player levels up
signal leveled_up(new_level: int)
## Signal executed when the current_xp changes
signal xp_changed(new_xp: float, new_neded_xp: float)
## Adds experience to the player
func add_experience(amount: float) -> void:
	current_xp += amount
	xp_changed.emit(current_xp, xp_for_next_lvl)
	while current_xp >= xp_for_next_lvl:
		current_xp = current_xp - xp_for_next_lvl
		current_level += 1
		xp_for_next_lvl = xp_for_next_lvl*1.20
		xp_changed.emit(current_xp, xp_for_next_lvl)
		leveled_up.emit(current_level)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_key"):
		add_experience(9000000000000)
