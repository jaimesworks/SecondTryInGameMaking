extends CanvasLayer

@onready var health_bar : ProgressBar = $MarginContainer/VBoxContainer/HealthBar ##reference of the health bar
@onready var xp_bar : ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer/XpBar ##reference of the xp bar
@onready var level_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/LevelLabel ##reference of the level label
@onready var experience_component : ExperienceComponent = get_tree().get_first_node_in_group("player").get_node("ExperienceComponent") ## reference of the player's ExperienceComponent
@onready var health_component : HealthComponent = get_tree().get_first_node_in_group("player").get_node("HealthComponent")  ## reference of the player's HealthComponent

func _ready() -> void:
	health_bar.max_value = health_component.max_hp
	health_bar.value = health_bar.max_value
	xp_bar.max_value = experience_component.xp_for_next_lvl
	xp_bar.value = experience_component.current_xp
	level_label.text = "Level: " + str(experience_component.current_level)
	experience_component.xp_changed.connect(_xp_bar_changed)
	experience_component.leveled_up.connect(_level_label_changed)
	health_component.hp_changed.connect(_health_bar_changed)


##Changes the xp bar with the [param new_xp] and the [param new_needed_xp]
func _xp_bar_changed(new_xp: float, new_needed_xp: float) -> void:
	xp_bar.max_value = new_needed_xp
	xp_bar.value = new_xp

##Changes the level label with the [param new_level]
func _level_label_changed(new_level: int) -> void:
	level_label.text = "Level: " + str(new_level)

##Changes the hp bar with the [param new_hp]
func _health_bar_changed(new_hp : float) -> void:
	health_bar.value = new_hp
