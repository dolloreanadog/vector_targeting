@tool
class_name BossController
extends CharacterBody3D

@export var action_list: Array[ActionComponent]:
	set(action):
		action_list = action
		#action_list.append(action)
		update_configuration_warnings()
@export var action_container: Node:
	set(container):
		action_container = container
		update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if action_list.is_empty():
		warnings.append("There is no action components.")
	if !is_instance_valid(action_container):
		warnings.append("There is no action container")
	
	return warnings

# INFO: This could've been in a state machine
# func choose_state()

## For now just have it randomly choose, though might switch to a system that iterates over list
func choose_action() -> void:
	var action: ActionComponent = action_list.pick_random()
	action.play_action()
