extends RefCounted
class_name Rarity
##Rarity tiers shared across the game, and the bonus multiplier of each one
enum Tier {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY} ##Possible tiers
##Each tier multiplier added to the base bonus
const MULTIPLIERS := {
	Tier.COMMON: 1.0,
	Tier.UNCOMMON: 2.0,
	Tier.RARE: 3.0,
	Tier.EPIC: 4.0,
	Tier.LEGENDARY: 5.0
}
