class_name Main
extends Node3D

@export var players: Array[PlayerController]
@export var boss: BossController

signal next_turn()

	# INFO: This should be fine
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_turn"):
		for player: PlayerController in players:
			player.randomize_stats()
		
		boss.choose_action()
		next_turn.emit()
