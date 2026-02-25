extends Area2D

@export var sprite1 : Sprite2D
@export var sprite2 : Sprite2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("aguaMaterial"):
		if sprite1.material:
			sprite1.material = null
		if sprite2.material:
			sprite2.material = null
