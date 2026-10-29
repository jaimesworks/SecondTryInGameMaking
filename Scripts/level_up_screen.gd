extends CanvasLayer

@export var modifier_pool : Array[ModifierData] ## The pool of the modifier that can appear

var modifier_inventory : ModifierInventory ##reference of the ModifierInventory
var modifiers_to_choose : Array[ModifierData] ## List of the modifiers that appear when Leveled Up
var tiers_to_choose : Array[Rarity.Tier] ## List of the tiers of the modifiers that appear when Leveled Up
var _pending_choices := 0 ## Counter of how many times the choices have to re-appear, used when the player levels up more than 1 time

@onready var button_list := $PanelContainer/VBoxContainer/HBoxContainer.get_children() ##reference of the buttons

func _ready() -> void:
	hide()
	get_tree().get_first_node_in_group("player").get_node("ExperienceComponent").leveled_up.connect(_on_leveled_up)
	modifier_inventory = get_tree().get_first_node_in_group("player").get_node("ModifierInventory")
	for i in range(button_list.size()):
		button_list[i].pressed.connect(_on_option_pressed.bind(i))

## Adds one time to the pending choices and if the screen is not visible, makes it visible
func _on_leveled_up(_new_level: int) -> void:
	_pending_choices += 1
	if not visible:
		_show_choices()

## Makes the choices appear and picks random modifiers and tiers for them. If nothing can be upgraded, closes the screen and discards the pending choices
func _show_choices() -> void:
	#vacio los array de los modificadores y tiers a elegir
	modifiers_to_choose.clear()
	tiers_to_choose.clear()
	#creo array de candidatos a salir en las opciones vacio
	var candidates : Array[ModifierData]
	#recorro el pool y meto en los candidatos solo los que se puedan meter en el inventario o subir de nivel
	for modifier in modifier_pool:
		if modifier_inventory.can_upgrade(modifier):
			candidates.append(modifier)
	if candidates.is_empty():
		_pending_choices = 0
		close()
		return
	candidates.shuffle()
	for i in range(button_list.size()):
		if i < candidates.size():
			button_list[i].show()
			var modifier_value : ModifierData = candidates[i]
			var tier_value : Rarity.Tier = Rarity.Tier.values().pick_random()
			modifiers_to_choose.append(modifier_value)
			tiers_to_choose.append(tier_value)
			button_list[i].text = modifier_value.display_name + "\n" + Rarity.Tier.keys()[tier_value]
		else:
			button_list[i].hide()

	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

##Hides the screen and unpauses the game
func close() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

## Applies the modifier and if there are pending choices makes the screen reappear
func _on_option_pressed(index: int) -> void:
	modifier_inventory.upgrade(modifiers_to_choose[index], tiers_to_choose[index])
	_pending_choices -= 1
	if _pending_choices > 0:
		_show_choices()
	else:
		close()
