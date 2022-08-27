tool
extends Node2D

export (Color) var color
export (float) var radius = 5


func _process(delta: float) -> void:
	update()


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
