extends Node
class_name ModifierInventory
## Stores the modifiers of its parent, can check if they can be upgraded and also upgrade them 
@export var max_slots := 4 ## maximum of modifiers it can store
var levels := {} ## Current modifiers stored and their levels
@onready var stats_component : StatsComponent = get_parent().get_node("StatsComponent") ##reference to the StatsComponent of its parent

##Returns whether the [param modifier] can be upgraded or not
func can_upgrade(modifier: ModifierData) -> bool :
	#check if the modifier is already on inventory
	#if yes, return false if is already maxed out
	#if not, return false if the inventory is full
	if levels.has(modifier) :
		return levels[modifier] < modifier.max_level
	return levels.size() < max_slots

##Upgrades the [param modifier] with the [param tier] indicated if it can and returns wether it was or not upgraded
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
