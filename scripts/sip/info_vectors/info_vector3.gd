class_name InfoVector3
extends InfoVector

@export var vector: Vector3

func _init(new_target: Variant, new_vector: Vector3) -> void:
	target = new_target
	vector = new_vector


func compare(info_vector: InfoVector, mode: int) -> bool:
	if info_vector is InfoVector3:
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
