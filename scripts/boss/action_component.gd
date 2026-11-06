@tool # I would make this into an abstract, if there was any real reason to right now.
## What decides what it does and how it targets
class_name ActionComponent
extends Node

enum VectorType {VECTOR2, VECTOR3, VECTOR4}
enum TargetMode {CLOSEST, FARTHEST, CUSTOM}

#@export var boss: BossController
@export var action_name: String

@export_group("Target Stats") 
@export var vector_type: VectorType:
	set(type):
		vector_type = type
		update_configuration_warnings()
@export_subgroup("Target Types")
@export var type_stat_x: Global.StatTypes:
	set(type):
		type_stat_x = type
		update_configuration_warnings()
@export var type_stat_y: Global.StatTypes:
	set(type):
		type_stat_y = type
		update_configuration_warnings()
@export var type_stat_z: Global.StatTypes:
	set(type):
		type_stat_z = type
		update_configuration_warnings()
@export var type_stat_w: Global.StatTypes:
	set(type):
		type_stat_w = type
		update_configuration_warnings()
@export_subgroup("Coordinates") ## The coordinates it is targeting
@export var target_stat_x: float
@export var target_stat_y: float
@export var target_stat_z: float
@export var target_stat_w: float

@export_group("Targeting")
## How many times it
@export var times: int = 1
@export var target_type: TargetMode

signal action_started(action: String)
signal action_ended(action: String)
signal found_target(targets: Array[InfoVector], types: Array[Global.StatTypes], coord: Vector4, new_name: String)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	match vector_type:
		VectorType.VECTOR2:
			# Check if we're utilizing x & y
			if type_stat_x == Global.StatTypes.NONE or type_stat_y == Global.StatTypes.NONE:
				warnings.append("Vector2: We are not using [b]type_stat_x, type_stat_y[/b].")
			# Check if z & w has something, but wrong vector
			if type_stat_z != Global.StatTypes.NONE or type_stat_w != Global.StatTypes.NONE:
				warnings.append("Vector2: We are using [b]type_stat_z, type_stat_w[/b].")
		VectorType.VECTOR3:
			# Check if we're utilizing x & y & z
			if type_stat_x == Global.StatTypes.NONE or type_stat_y == Global.StatTypes.NONE or type_stat_z == Global.StatTypes.NONE:
				warnings.append("Vector3: We are not using [b]type_stat_x, type_stat_y, type_stat_z[/b].")
			# Check if w has something, but wrong vector
			if type_stat_w != Global.StatTypes.NONE:
				warnings.append("Vector3: We are using [b]type_stat_w[/b].")
		VectorType.VECTOR4:
			if type_stat_x == Global.StatTypes.NONE or type_stat_y == Global.StatTypes.NONE or type_stat_z == Global.StatTypes.NONE or type_stat_w == Global.StatTypes.NONE:
				warnings.append("Vector4: We are not using [b]type_stat_x, type_stat_y, type_stat_z[/b].")
	
	return warnings

## This could be changed depending on the game, but this allows some flexibility
func grab_targets() -> Array[InfoVector]:
	var array: Array[InfoVector]
	var new_array: Array[InfoVector]
	#match vector_type:
		#VectorType.VECTOR2:
			#var new_array: Array[InfoVector2] = Global.grab_targets_info_vector2(type_stat_x, type_stat_y)
			#new_array = Global.sort_targets_info_vector2(new_array)
			#print("Targets Array: %s" % [new_array])
			## TODO: Then we run for statement to get the top x (times) or bottom x (times) and put it on array
			#return new_array
		#VectorType.VECTOR3:
			#var new_array: Array[InfoVector3] = Global.grab_targets_info_vector3(type_stat_x, type_stat_y, type_stat_z)
			#new_array = Global.sort_targets_info_vector3(new_array)
			#print("Targets Array: %s" % [new_array])
			## TODO: Then we run for statement to get the top x (times) or bottom x (times) and put it on array
		#VectorType.VECTOR4:
			#var new_array: Array[InfoVector4] = Global.grab_targets_info_vector4(type_stat_x, type_stat_y, type_stat_z, type_stat_w)
			#new_array = Global.sort_targets_info_vector4(new_array)
			#print("Targets Array: %s" % [new_array])
			## TODO: Then we run for statement to get the top x (times) or bottom x (times) and put it on array
	
	array = Global.grab_targets_info_vector(type_stat_x, type_stat_y, type_stat_z, type_stat_w)
	
	match target_type:
		TargetMode.CLOSEST:
			array.sort_custom(Global.sort_descending)
		TargetMode.FARTHEST:
			array.sort_custom(Global.sort_ascending)
		TargetMode.CUSTOM:
			push_error("Not implemented")
	
	for x: int in times:
		new_array.append(array[x])
	
	#assert(false, "Couldn't find target: %s" % [vector_type])
	
	return new_array

func play_action() -> void:
	action_started.emit(action_name)
	var targets: Array[InfoVector] = grab_targets()
	print(targets)
	_start_action(targets)

## Overridable, but we're not doing anything special
func _start_action(info_vectors: Array[InfoVector]) -> void:
	# TODO: We want to show targeted players, but also draw a line between boss and targeted player
	print("Targets: %s" % [action_name])
	print(info_vectors)
	emit_targets(info_vectors)
	for target: InfoVector in info_vectors:
		print("Target name: %s" % [target.target.name])

# Shouldn't in actual version
func emit_targets(info_vectors: Array[InfoVector]) -> void:
	# targets: Array[InfoVector], types: Array[Global.StatTypes], coord: Vector4
	var new_types: Array[Global.StatTypes] = [type_stat_x, type_stat_y, type_stat_z, type_stat_w]
	var new_coord: Vector4 = Vector4(target_stat_x, target_stat_y, target_stat_z, target_stat_w)
	found_target.emit(info_vectors, new_types, new_coord, action_name)
