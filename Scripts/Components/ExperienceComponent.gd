extends Node
class_name ExperienceComponent

var actual_xp := 0.0
var actual_level := 0
var xp_for_next_lvl := 10.0

signal leveled_up(new_level: int)

func on_leveled_up(new_level: int) -> void:
	print("Nuevo nivel: ", new_level)

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
