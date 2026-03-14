extends Control

@export var scoreTxt : Label
@export var score : Label
@export var hScore : Label

@export var parallax : Parallax2D

@export var botao_jogar : Button

var intensidade = 30.0
var suavidade = 5.0
var alvo = Vector2.ZERO

var usando_teclado = false

func _ready() -> void:
	ContadorTempo.parar_timer()
	
	if !Globals.dados.tempo_segs:
		scoreTxt.visible = false
		score.visible = false
	
	if !Globals.dados.high_tempo and Globals.dados.tempo_segs != 0:
		Globals.dados.high_tempo = Globals.dados.tempo_segs
	
	elif Globals.dados.tempo_segs != 0 and Globals.dados.tempo_segs < Globals.dados.high_tempo:
		Globals.dados.high_tempo = Globals.dados.tempo_segs
	
	var m = int(Globals.dados.tempo_segs / 60.0)
	var s = Globals.dados.tempo_segs % 60
	score.text = '%02d:%02d ' % [m, s]
	
	var hm = int(Globals.dados.high_tempo / 60.0)
	var hs = Globals.dados.high_tempo % 60
	hScore.text = '%02d:%02d ' % [hm, hs]
	Globals.salvar_jogo()

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
			botao_jogar.grab_focus()


	# 🖱 detecta movimento do mouse
	if event is InputEventMouseMotion:
		if usando_teclado:
			usando_teclado = false

			var foco = get_viewport().gui_get_focus_owner()
			if foco:
				foco.release_focus()

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport_rect().size
	
	var offset = (mouse_pos - screen_size / 2.0) / (screen_size / 2.0)
	alvo = offset * intensidade
	parallax.scroll_offset = parallax.scroll_offset.lerp(alvo, delta * suavidade)

func _on_jogar_pressed() -> void:
	ContadorTempo.reset_timer()
	
	Globals.reset_de_tinta()
	Globals.saveTanqueCena()
	
	get_tree().change_scene_to_file("res://Cenas/lvl_1.tscn")


func _on_menu_pressed() -> void:
	Globals.dados.speedrun_mode = false
	Globals.salvar_jogo()
	ContadorTempo.reset_timer()
	
	Transição.anim_in()
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file("res://Cenas/tela_inicial.tscn")
