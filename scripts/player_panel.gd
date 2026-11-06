@tool
class_name PlayerPanel
extends Panel

@export var player: PlayerController

@onready var label: Label = $VBoxContainer/Label

@onready var stat_info_container: StatInfoContainer = $VBoxContainer/StatInfoContainer
@onready var stat_info_container_2: StatInfoContainer = $VBoxContainer/StatInfoContainer2
@onready var stat_info_container_3: StatInfoContainer = $VBoxContainer/StatInfoContainer3
@onready var stat_info_container_4: StatInfoContainer = $VBoxContainer/StatInfoContainer4

func _ready() -> void:
	label.text = player.name
