extends RefCounted
class_name Rarity

enum Tier {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}
const MULTIPLIERS := {
	Tier.COMMON: 1.0,
	Tier.UNCOMMON: 2.0,
	Tier.RARE: 3.0,
	Tier.EPIC: 4.0,
	Tier.LEGENDARY: 5.0
}
