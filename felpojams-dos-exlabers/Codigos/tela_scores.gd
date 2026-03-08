extends Control

@export var scoreTxt : Label
@export var score : Label
@export var hScore : Label

func _ready() -> void:
	ContadorTempo.parar_timer()
	
	if !Globals.tempo_segs != 0:
		scoreTxt.visible = false
		score.visible = false
	
	if !Globals.high_tempo and Globals.tempo_segs != 0:
		Globals.high_tempo = Globals.tempo_segs
	
	elif Globals.tempo_segs < Globals.high_tempo:
		Globals.high_tempo = Globals.tempo_segs
	
	var m = int(Globals.tempo_segs / 60.0)
	var s = Globals.tempo_segs % 60
	score.text = '%02d:%02d ' % [m, s]
	
	var hm = int(Globals.high_tempo / 60.0)
	var hs = Globals.high_tempo % 60
	hScore.text = '%02d:%02d ' % [hm, hs]

func _on_jogar_pressed() -> void:
	ContadorTempo.reset_timer()
	
	Globals.reset_de_tinta()
	Globals.saveTanqueCena()
	
	get_tree().change_scene_to_file("res://Cenas/lvl_1.tscn")


func _on_menu_pressed() -> void:
	Globals.speedrun_mode = false
	ContadorTempo.reset_timer()
	
	Transição.anim_in()
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file("res://Cenas/tela_inicial.tscn")
