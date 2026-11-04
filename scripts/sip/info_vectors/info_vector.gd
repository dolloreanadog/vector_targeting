@abstract
class_name InfoVector
extends Resource

@export var target: Variant

## Compares similar vectors (target (>,==,<) self) [br]
## -1 = less (<), 0 = more (==), 1 = more (>)
@abstract func compare(info_vector: InfoVector, mode: int) -> bool;
