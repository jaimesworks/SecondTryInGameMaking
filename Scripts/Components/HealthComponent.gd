extends Node
class_name HealthComponent
#Señales:
signal died

@export var max_hp : float = 100
var current_hp : float

func _ready() -> void:
	current_hp = max_hp

func take_damage(amount: float):
	if current_hp == 0:
		return
	current_hp = clamp(current_hp - amount, 0, max_hp)
	print(get_parent().name, " has taken: ", current_hp, " hp")
	if current_hp == 0:
		died.emit()
