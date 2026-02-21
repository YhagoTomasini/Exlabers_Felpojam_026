extends Area2D

@export var sprite : Sprite2D


func bounce():
	print("bounce")
	var tween = create_tween()
	
	tween.tween_property(sprite, "scale", Vector2(1.2, 0.7), 0.08)
	tween.tween_property(sprite, "scale", Vector2(0.9, 1.15), 0.12)
	tween.tween_property(sprite, "scale", Vector2.ONE, 0.1)
