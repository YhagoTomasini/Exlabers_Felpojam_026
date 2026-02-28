extends Control

@export var pause : Control
@export var voltarB : Button

var tavaPause : bool
var podeVoltar : bool

var noReset : bool

var usando_teclado : bool

func _ready() -> void:
	visible = false
	podeVoltar = false
	tavaPause = false
	noReset = false
	
	usando_teclado = false
	
func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("ui_pause") or event.is_action_pressed("reset"):
			if tavaPause:
				voltarPause()
			else:
				voltarJogo()
			return
				
		if event.is_action_pressed("ui_up") \
		or event.is_action_pressed("ui_down") \
		or event.is_action_pressed("ui_left") \
		or event.is_action_pressed("ui_right"):

			if not usando_teclado:
				usando_teclado = true

			if not get_viewport().gui_get_focus_owner():
				voltarB.grab_focus()

		# 🖱 mouse
		if event is InputEventMouseMotion:
			if usando_teclado:
				usando_teclado = false

				var foco = get_viewport().gui_get_focus_owner()
				if foco:
					foco.release_focus()
		return
					
	if event.is_action_pressed("reset") and !tavaPause and !noReset:
		visible = true
		get_tree().paused = true
		grabFocus()	
	
func voltarPause():
	pause.grabFocus()
	tavaPause = false
	#await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	podeVoltar = false
	pause.visible = true
	visible = false
	
	
	
func voltarJogo():
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)

	get_tree().paused = false
	visible = false
	#await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	noReset = false
	pause.noReset = false
	podeVoltar = false
	tavaPause = false
	
	
func grabFocus():
	podeVoltar = true
	noReset = true
	pause.noReset = true
	
	AudioManager.pitch_tema(2, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(2, SoundEffect.TIPO_DE_SOM.TEMA2)
	

func _on_voltar_pressed() -> void:
	if podeVoltar:
		if tavaPause:
			voltarPause()
		else:
			voltarJogo()


func _on_resetar_fase_pressed() -> void:
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)
	
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.MORTE)
	Globals.refil_de_tinta()
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")


func _on_resetar_jogo_pressed() -> void:
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)

	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.MORTE)
	Globals.reset_de_tinta()
	Globals.saveTanqueCena()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/lvl_1.tscn")
