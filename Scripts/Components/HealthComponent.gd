extends Node
class_name HealthComponent 
## Stores the health of the parent, calculates it changes and emits when its 0
signal died ## Signal emited when the hp is 0
signal hp_changed(new_hp: float) ## Signal emited when the hp changes

@export var max_hp : float = 100 ## The maximum Hp it can contain
var current_hp : float ## The current Hp it contains

func _ready() -> void:
	current_hp = max_hp

## Removes [param amount] of the current hp, cant be lower than 0. If its already 0 doesnt do anything
func take_damage(amount: float):
	if current_hp == 0:
		return
	current_hp = clamp(current_hp - amount, 0, max_hp)
	hp_changed.emit(current_hp)
	print(get_parent().name, " has taken: ", current_hp, " hp")
	if current_hp == 0:
		died.emit()
