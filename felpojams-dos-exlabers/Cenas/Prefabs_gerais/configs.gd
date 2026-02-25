extends Control

@export var pause : Control
@export var voltarB : Button

@onready var corFundo :ColorRect = $ColorRect

var podeVoltar : bool

func _ready() -> void:
	corFundo.color = Color(0.58, 0.0, 0.188, 0.486)
	visible = false
	podeVoltar = false

func _unhandled_input(event: InputEvent) -> void:
	if podeVoltar:
		if event.is_action_pressed("ui_pause"):
			voltarPause()

func _on_button_button_down() -> void:
	voltarPause()
	
func voltarPause():
	podeVoltar = false
	pause.visible = true
	visible = false
	pause.grabFocus()

func grabFocus():
	await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	podeVoltar = true
	voltarB.grab_focus()
	
