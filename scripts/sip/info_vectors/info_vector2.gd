class_name InfoVector2
extends InfoVector

@export var vector: Vector2

func _init(new_target: Variant, new_vector: Vector2) -> void:
	target = new_target
	vector = new_vector

# Have to do it this way, if this was C# we could've easily overloaded

func compare(info_vector: InfoVector, mode: int) -> bool:
	if info_vector is InfoVector2:
		match mode:
			-1:
				if info_vector.vector < vector:
					return true
				else:
					return false
			0:
				if info_vector.vector == vector:
					return true
				else:
					return false
			1:
				if info_vector.vector > vector:
					return true
				else:
					return false
	
	assert(false, "Comparing didn't work")
	return false
