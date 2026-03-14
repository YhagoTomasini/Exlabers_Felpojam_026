extends Control

@onready var timer = $Timer
@onready var canva = $CanvasLayer

func _ready() -> void:
	canva.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_paste"):
		Globals.dados.finalizou = true
		get_tree().call_deferred("change_scene_to_file","res://Cenas/tela_inicial.tscn")
		
func iniciar_timer():
	print("iniciar")
	if timer.is_stopped():
		print("iniciado")
		canva.visible = true
		timer.start()
	
func parar_timer():
	canva.visible = false
	timer.stop()
	
func reset_timer():
	Globals.dados.tempo_segs = 0
	
func _on_timer_timeout() -> void:
	Globals.dados.tempo_segs += 1
	var m = int(Globals.dados.tempo_segs / 60.0)
	var s = Globals.dados.tempo_segs % 60
	%Label.text = '%02d:%02d ' % [m, s]
	
	
	
