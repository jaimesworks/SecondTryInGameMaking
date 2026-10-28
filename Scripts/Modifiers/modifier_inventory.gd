extends Node
class_name ModifierInventory

@export var max_slots := 4
var levels := {}
@onready var stats_component : StatsComponent = get_parent().get_node("StatsComponent")

func can_upgrade(modifier: ModifierData) -> bool :
	#check if the modifier is already on inventory
	#if yes, return false if is already maxed out
	#if not, return false if the inventory is full
	if levels.has(modifier) :
		return levels[modifier] < modifier.max_level
	return levels.size() < max_slots

func upgrade(modifier: ModifierData, tier : Rarity.Tier) -> bool:
	if !can_upgrade(modifier):
		return false
	if !levels.has(modifier):
		levels[modifier] = 1
	else :
		levels[modifier] += 1
	var bonus :float = modifier.base_bonus * Rarity.MULTIPLIERS[tier]
	stats_component.add_bonus(modifier.stat_to_upgrade, bonus)
	print("Modifier: ",modifier.display_name, " Level: ", levels[modifier], " UpgradeRarity: ", Rarity.Tier.keys()[tier], " Bonus: ", bonus)
	return true
