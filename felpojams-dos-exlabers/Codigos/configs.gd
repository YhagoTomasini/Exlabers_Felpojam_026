extends Control


@export var pause : Control

func _ready() -> void:
	visible = false
	
func _on_button_button_down() -> void:
	pause.visible = true
	visible = false
