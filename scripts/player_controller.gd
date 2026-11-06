@tool
class_name PlayerController
extends CharacterBody3D

@onready var label_3d: Label3D = $Label3D
@export var panel: PlayerPanel

@export_group("Stats")
@export var player_id: int
#@export var ability_1: AbilityComponent
#@export var ability_2: AbilityComponent
#@export var ability_3: AbilityComponent
#@export var ability_4: AbilityComponent
#@export var health: healthComponent
@export var health: float
@export var deaths: float
@export var total_damage: float
@export var dps: float
@export var total_support: float
@export var sps: float
@export var players_near: float
@export var survival_time: float
@export var boss_distance: float
@export var short_health_pool: float
@export var potential: float
@export var support_by: float
@export var is_dead: float
@export var ability_1_cooldown: float
@export var ability_2_cooldown: float
@export var ability_3_cooldown: float
@export var ability_4_cooldown: float
@export var player_class: float

func _ready() -> void:
	player_id = randi_range(0, 9999)
	potential = randf_range(0, 9999)
	player_class = float(randi_range(0, 1))
	label_3d.text = name


func randomize_stats() -> void:
	health = randf_range(0, 100)
	deaths = float(randi_range(0, 100))
	total_damage = randf_range(0, 9999)
	dps = randf_range(0, 9999)
	total_support = randf_range(0, 9999)
	sps = randf_range(0, 9999)
	players_near = float(randi_range(0, 100))
	survival_time = randf_range(0, 9999)
	boss_distance = randf_range(-9999, 9999)
	short_health_pool = randf_range(-9999, 9999)
	support_by = randf_range(0, 9999)
	is_dead = float(randi_range(0, 1))
	ability_1_cooldown = randf_range(0, 100)
	ability_2_cooldown = randf_range(0, 100)
	ability_3_cooldown = randf_range(0, 100)
	ability_4_cooldown = randf_range(0, 100)


func grab_stat(stat: Global.StatTypes) -> float:
	match stat:
		Global.StatTypes.ABILITY1COOLDOWN:
			return ability_1_cooldown
		Global.StatTypes.ABILITY2COOLDOWN:
			return ability_2_cooldown
		Global.StatTypes.ABILITY3COOLDOWN:
			return ability_3_cooldown
		Global.StatTypes.ABILITY4COOLDOWN:
			return ability_4_cooldown
		Global.StatTypes.HEALTH:
			return health
		Global.StatTypes.DEATHS:
			return deaths
		Global.StatTypes.TOTALDAMAGE:
			return total_damage
		Global.StatTypes.DPS:
			return dps
		Global.StatTypes.TOTALSUPPORT:
			return total_support
		Global.StatTypes.SPS:
			return sps
		Global.StatTypes.PLAYERSNEAR:
			return players_near
		Global.StatTypes.SHORTHEALTHPOOL:
			return short_health_pool
		Global.StatTypes.SURVIVALTIME:
			return survival_time
		Global.StatTypes.DISTANCEBOSS:
			return boss_distance
		Global.StatTypes.SUPPORTEDBY:
			return support_by
		Global.StatTypes.ISDEAD:
			return is_dead
		Global.StatTypes.CLASS:
			return player_class
	
	return 0

func grab_info_vector2(x: Global.StatTypes, y: Global.StatTypes) -> InfoVector2:
	var new_info_vector: InfoVector2
	var new_x: float = grab_stat(x)
	var new_y: float = grab_stat(y)
	new_info_vector = InfoVector2.new(self, Vector2(new_x, new_y))
	return new_info_vector

func grab_info_vector3(x: Global.StatTypes, y: Global.StatTypes, z: Global.StatTypes) -> InfoVector3:
	var new_info_vector: InfoVector3
	var new_x: float = grab_stat(x)
	var new_y: float = grab_stat(y)
	var new_z: float = grab_stat(z)
	new_info_vector = InfoVector3.new(self, Vector3(new_x, new_y, new_z))
	return new_info_vector

func grab_info_vector4(x: Global.StatTypes, y: Global.StatTypes, z: Global.StatTypes, w: Global.StatTypes) -> InfoVector4:
	var new_info_vector: InfoVector4
	var new_x: float = grab_stat(x)
	var new_y: float = grab_stat(y)
	var new_z: float = grab_stat(z)
	var new_w: float = grab_stat(w)
	new_info_vector = InfoVector4.new(self, Vector4(new_x, new_y, new_z, new_w))
	return new_info_vector
