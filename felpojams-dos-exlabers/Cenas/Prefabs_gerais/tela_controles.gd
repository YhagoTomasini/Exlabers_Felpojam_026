extends Control

@export var voltarB : Button
var usando_teclado : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	usando_teclado = false
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	# 🎮 detecta teclado / controle
	if visible:
		if event.is_action_pressed("ui_up_ui") \
		or event.is_action_pressed("ui_down") \
		or event.is_action_pressed("ui_left") \
		or event.is_action_pressed("ui_right"):

			if not usando_teclado:
				usando_teclado = true

				# se ninguém estiver focado, foca o primeiro botão
			#if not get_viewport().gui_get_focus_owner():
				voltarB.grab_focus()

		# 🖱 detecta movimento do mouse
		if event is InputEventMouseMotion:
			if usando_teclado:
				usando_teclado = false

				var foco = get_viewport().gui_get_focus_owner()
				if foco:
					foco.release_focus()

func _on_voltar_pressed() -> void:
	voltar()

func ativar():
	var foco = get_viewport().gui_get_focus_owner()
	if foco:
		foco.release_focus()
	
	await get_tree().process_frame
	voltarB.grab_focus()
	
	AudioManager.pitch_tema(2, SoundEffect.TIPO_DE_SOM.TEMA2)
	visible = true
	
func voltar():
	
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)
	visible = false
	
	var foco = get_viewport().gui_get_focus_owner()
	if foco:
		foco.release_focus()
