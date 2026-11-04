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

#func grab_targets_info_vector2(x: StatTypes, y: StatTypes) -> Array[InfoVector2]:
	#var vectors: Array[InfoVector2]
	#for target: PlayerController in get_tree().get_nodes_in_group("Targets"):
		#vectors.append(target.grab_info_vector2(x, y))
	#return vectors
#
#func grab_targets_info_vector3(x: StatTypes, y: StatTypes, z: StatTypes) -> Array[InfoVector3]:
	#var vectors: Array[InfoVector3]
	#for target: PlayerController in get_tree().get_nodes_in_group("Targets"):
		#vectors.append(target.grab_info_vector3(x, y, z))
	#return vectors
#
#func grab_targets_info_vector4(x: StatTypes, y: StatTypes, z: StatTypes, w: StatTypes) -> Array[InfoVector4]:
	#var vectors: Array[InfoVector4]
	#for target: PlayerController in get_tree().get_nodes_in_group("Targets"):
		#vectors.append(target.grab_info_vector4(x, y, z, w))
	#return vectors
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

#func sort_targets_info_vector2(array: Array[InfoVector2]) -> Array[InfoVector2]:
	#var vectors: Array[InfoVector2] = array
	#vectors.sort_custom(sort_ascending)
	#return vectors
#
#func sort_targets_info_vector3(array: Array[InfoVector3]) -> Array[InfoVector3]:
	#var vectors: Array[InfoVector3] = array
	#vectors.sort_custom(sort_ascending)
	#return vectors
#
#func sort_targets_info_vector4(array: Array[InfoVector4]) -> Array[InfoVector4]:
	#var vectors: Array[InfoVector4] = array
	#vectors.sort_custom(sort_ascending)
	#return vectors
#endregion
