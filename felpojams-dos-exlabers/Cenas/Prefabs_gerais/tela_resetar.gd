extends Control

@export var pause : Control
@export var voltarB : Button

var tavaPause : bool
var podeVoltar : bool

var noReset : bool

func _ready() -> void:
	visible = false
	podeVoltar = false
	tavaPause = false
	noReset = false

func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("ui_pause"):
			return

	if !noReset:
		if event.is_action_pressed("reset") and !tavaPause:
			visible = true
			get_tree().paused = true
			grabFocus()

	if podeVoltar:
		if event.is_action_pressed("ui_pause") or event.is_action_pressed("reset"):
			if tavaPause:
				voltarPause()
			else:
				voltarJogo()
	
func voltarPause():
	pause.grabFocus()
	tavaPause = false
	await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	podeVoltar = false
	pause.visible = true
	visible = false
	
	
func voltarJogo():
	get_tree().paused = false
	visible = false
	await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	noReset = false
	pause.noReset = false
	podeVoltar = false
	tavaPause = false

func grabFocus():
	await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	podeVoltar = true
	noReset = true
	pause.noReset = true
	voltarB.grab_focus()
	

func _on_resetar_fase_button_down() -> void:
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.MORTE)
	Globals.refil_de_tinta()
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")
	

func _on_resetar_jogo_button_down() -> void:
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.MORTE)
	Globals.reset_de_tinta()
	Globals.saveTanqueCena()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/lvl_1.tscn")


func _on_voltar_pressed() -> void:
	if podeVoltar:
		if tavaPause:
			voltarPause()
		else:
			voltarJogo()
