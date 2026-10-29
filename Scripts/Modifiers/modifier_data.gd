extends Resource
class_name ModifierData
## Resource for the modifiers
@export var display_name : String ## The name it displays
@export var stat_to_upgrade : StatsComponent.Stat ## The stat it affects
@export var base_bonus: float ## The minimum bonus it gives
@export var max_level: int ## The max level it can hit
