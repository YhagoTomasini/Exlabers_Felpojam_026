extends Control

@export var pause : Control
@export var voltarB : Button

func _ready() -> void:
	visible = false
	
func _on_button_button_down() -> void:
	pause.visible = true
	visible = false
	pause.grabFocus()

func grabFocus():
	voltarB.grab_focus()
