@tool
class_name StatInfoContainer
extends HBoxContainer

@onready var stat_name_label: Label = $StatNameLabel
@onready var stat_number_label: Label = $StatNumberLabel

@export var stat_name: String:
	set(value):
		stat_name = value
		if Engine.is_editor_hint() or is_instance_valid(stat_name_label):
			stat_name_label.text = value
@export var stat_number: String:
	set(value):
		stat_number = value
		if Engine.is_editor_hint() or is_instance_valid(stat_number_label):
			stat_number_label.text = value

func _ready() -> void:
	stat_name_label.text = stat_name
	stat_number_label.text = stat_number
