class_name Main
extends Node3D

enum CameraMode {BACK, SIDE}

@export var players: Array[PlayerController]
@export var boss: BossController

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var line_group: Node3D = $LineGroup

@onready var action_name_label: Label = $Camera3D/UI/HBoxContainer/BossActionPanel/VBoxContainer/ActionNameLabel
@onready var stat_info_container: StatInfoContainer = $Camera3D/UI/HBoxContainer/BossActionPanel/VBoxContainer/StatInfoContainer
@onready var stat_info_container_2: StatInfoContainer = $Camera3D/UI/HBoxContainer/BossActionPanel/VBoxContainer/StatInfoContainer2
@onready var stat_info_container_3: StatInfoContainer = $Camera3D/UI/HBoxContainer/BossActionPanel/VBoxContainer/StatInfoContainer3
@onready var stat_info_container_4: StatInfoContainer = $Camera3D/UI/HBoxContainer/BossActionPanel/VBoxContainer/StatInfoContainer4

@onready var player_panel: PlayerPanel = $Camera3D/UI/HBoxContainer/PlayerPanel
@onready var player1_stat_info_container: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel/VBoxContainer/StatInfoContainer
@onready var player1_stat_info_container_3: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel/VBoxContainer/StatInfoContainer3
@onready var player1_stat_info_container_2: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel/VBoxContainer/StatInfoContainer2
@onready var player1_stat_info_container_4: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel/VBoxContainer/StatInfoContainer4

@onready var player_panel_2: PlayerPanel = $Camera3D/UI/HBoxContainer/PlayerPanel2
@onready var player2_stat_info_container: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel2/VBoxContainer/StatInfoContainer
@onready var player2_stat_info_container_2: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel2/VBoxContainer/StatInfoContainer2
@onready var player2_stat_info_container_3: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel2/VBoxContainer/StatInfoContainer3
@onready var player2_stat_info_container_4: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel2/VBoxContainer/StatInfoContainer4

@onready var player_panel_3: PlayerPanel = $Camera3D/UI/HBoxContainer/PlayerPanel3
@onready var player3_stat_info_container: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel3/VBoxContainer/StatInfoContainer
@onready var player3_stat_info_container_2: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel3/VBoxContainer/StatInfoContainer2
@onready var player3_stat_info_container_3: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel3/VBoxContainer/StatInfoContainer3
@onready var player3_stat_info_container_4: StatInfoContainer = $Camera3D/UI/HBoxContainer/PlayerPanel3/VBoxContainer/StatInfoContainer4


var current_camera_mode: CameraMode = CameraMode.BACK


signal next_turn()

	# INFO: This should be fine
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_turn"):
		for player: PlayerController in players:
			player.randomize_stats()
		
		boss.choose_action()
		next_turn.emit()
	
	if Input.is_action_just_pressed("switch_mode_up"):
		if current_camera_mode != CameraMode.BACK:
			current_camera_mode = CameraMode.BACK
			get_tree().create_tween().tween_property(animation_tree, "parameters/blend_position", -1, 1)
			#animation_tree.set(, )
		else:
			current_camera_mode = CameraMode.SIDE
			get_tree().create_tween().tween_property(animation_tree, "parameters/blend_position", 1, 1)

func update_ui_info() -> void:
	pass


func create_line(from: Vector3, to: Vector3, color: Color = Color.WHITE) -> void:
	print("create line")
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	var im_mesh = ImmediateMesh.new()
	var material = ORMMaterial3D.new()
	
	# Configure material to be unshaded so it ignores lights and stays vibrant
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	# Begin drawing lines
	im_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	im_mesh.surface_add_vertex(from) # First point
	im_mesh.surface_add_vertex(to)   # Second point
	im_mesh.surface_end()
	
	# Assign the generated mesh to this MeshInstance3D
	mesh_instance.mesh = im_mesh
	line_group.add_child(mesh_instance)


func _on_action_component_found_target(targets: Array[InfoVector], types: Array[Global.StatTypes], coord: Vector4, new_name: String) -> void:
	for line: Node in line_group.get_children():
		line.queue_free()
	print("found: %s" % [targets])
	for player: PlayerController in players:
		# Add targeting info into boss panel
		action_name_label.text = new_name
		
		stat_info_container.stat_name = Global.stat_type_to_string(types[0])
		stat_info_container_2.stat_name = Global.stat_type_to_string(types[1])
		stat_info_container_3.stat_name = Global.stat_type_to_string(types[2])
		stat_info_container_4.stat_name = Global.stat_type_to_string(types[3])
		
		stat_info_container.stat_number = str(coord.x)
		stat_info_container_2.stat_number = str(coord.y)
		stat_info_container_3.stat_number = str(coord.z)
		stat_info_container_4.stat_number = str(coord.w)
		
		player.panel.self_modulate = Color(Color.RED)
		for target: InfoVector in targets:
			print(target.target.name)
			if target.target.name == player.name:
				player.panel.self_modulate = Color(Color.GREEN)
				create_line(boss.global_position, player.global_position)
		
		player.panel.stat_info_container.stat_name = Global.stat_type_to_string(types[0])
		player.panel.stat_info_container_2.stat_name = Global.stat_type_to_string(types[1])
		player.panel.stat_info_container_3.stat_name = Global.stat_type_to_string(types[2])
		player.panel.stat_info_container_4.stat_name = Global.stat_type_to_string(types[3])
		
		player.panel.stat_info_container.stat_number = str(snappedf(player.grab_stat(types[0]), 0.01))
		player.panel.stat_info_container_2.stat_number = str(snappedf(player.grab_stat(types[1]), 0.01))
		player.panel.stat_info_container_3.stat_number = str(snappedf(player.grab_stat(types[2]), 0.01))
		player.panel.stat_info_container_4.stat_number = str(snappedf(player.grab_stat(types[3]), 0.01))
