extends Line2D


onready var stop_point = get_children()


func _ready() -> void:
	for child in stop_point:
		add_point(child.global_position)
