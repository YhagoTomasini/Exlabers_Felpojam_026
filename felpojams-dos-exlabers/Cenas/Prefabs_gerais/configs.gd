extends Control

@export var pause : Control
@export var voltarB : Button

@onready var cor_fundo: ColorRect = $corFundo

var usando_teclado = false

var podeVoltar : bool

func _ready() -> void:
	cor_fundo.color = Color(0.58, 0.0, 0.188, 0.486)
	visible = false
	podeVoltar = false

func _input(event):
	# 🎮 detecta teclado / controle
	if event.is_action_pressed("ui_up") \
	or event.is_action_pressed("ui_down") \
	or event.is_action_pressed("ui_left") \
	or event.is_action_pressed("ui_right"):

		if not usando_teclado:
			usando_teclado = true

			# se ninguém estiver focado, foca o primeiro botão
		if not get_viewport().gui_get_focus_owner():
			voltarB.grab_focus()


	# 🖱 detecta movimento do mouse
	if event is InputEventMouseMotion:
		if usando_teclado:
			usando_teclado = false

			var foco = get_viewport().gui_get_focus_owner()
			if foco:
				foco.release_focus()

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
	
