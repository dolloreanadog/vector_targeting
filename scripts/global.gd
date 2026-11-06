extends Node

enum StatTypes {
	NONE,
	ABILITY1COOLDOWN,
	ABILITY2COOLDOWN,
	ABILITY3COOLDOWN,
	ABILITY4COOLDOWN,
	HEALTH,
	DEATHS,
	TOTALDAMAGE,
	DPS,
	TOTALSUPPORT,
	SPS,
	PLAYERSNEAR,
	SHORTHEALTHPOOL,
	SURVIVALTIME,
	DISTANCEBOSS,
	SUPPORTEDBY,
	ISDEAD,
	CLASS
	}

func stat_type_to_string(type: StatTypes) -> String:
	match type:
		StatTypes.NONE:
			return "None"
		StatTypes.ABILITY1COOLDOWN:
			return "Ability 1 Cooldown"
		StatTypes.ABILITY2COOLDOWN:
			return "Ability 2 Cooldown"
		StatTypes.ABILITY3COOLDOWN:
			return "Ability 3 Cooldown"
		StatTypes.ABILITY4COOLDOWN:
			return "Ability 4 Cooldown"
		StatTypes.HEALTH:
			return "Health"
		StatTypes.DEATHS:
			return "Deaths"
		StatTypes.TOTALDAMAGE:
			return "Total Damage"
		StatTypes.DPS:
			return "DPS"
		StatTypes.TOTALSUPPORT:
			return "Total Support"
		StatTypes.SPS:
			return "SPS"
		StatTypes.PLAYERSNEAR:
			return "Players Near"
		StatTypes.SHORTHEALTHPOOL:
			return "Short Health Pool"
		StatTypes.SURVIVALTIME:
			return "Survival Pool"
		StatTypes.DISTANCEBOSS:
			return "Distance Boss"
		StatTypes.SUPPORTEDBY:
			return "Supported By"
		StatTypes.ISDEAD:
			return "Is Dead"
		StatTypes.CLASS:
			return "Class"
	return ""
#region Grab Info Targets
func grab_targets_info_vector(x: StatTypes = StatTypes.NONE, y: StatTypes = StatTypes.NONE, z: StatTypes = StatTypes.NONE, w: StatTypes = StatTypes.NONE) -> Array[InfoVector]:
	var vectors: Array[InfoVector]
	if x != StatTypes.NONE and y != StatTypes.NONE and z == StatTypes.NONE and w == StatTypes.NONE:
		for target: PlayerController in get_tree().get_nodes_in_group("Targets"):
			vectors.append(target.grab_info_vector2(x, y))
		return vectors
	
	if x != StatTypes.NONE and y != StatTypes.NONE and z != StatTypes.NONE and w == StatTypes.NONE:
		for target: PlayerController in get_tree().get_nodes_in_group("Targets"):
			vectors.append(target.grab_info_vector3(x, y, z))
		return vectors
	
	if x != StatTypes.NONE and y != StatTypes.NONE and z != StatTypes.NONE and w != StatTypes.NONE:
		for target: PlayerController in get_tree().get_nodes_in_group("Targets"):
			vectors.append(target.grab_info_vector4(x, y, z, w))
		return vectors
	
	push_error("One or more parameters are wrong!")
	return vectors
#endregion

#region Sorting
func sort_ascending(a: InfoVector, b: InfoVector) -> bool:
	if a.compare(b, -1):
		return true
	return false

func sort_descending(a: InfoVector, b: InfoVector) -> bool:
	if a.compare(b, 1):
		return true
	return false
#endregion
