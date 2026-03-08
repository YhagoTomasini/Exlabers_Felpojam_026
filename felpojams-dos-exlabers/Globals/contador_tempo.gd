extends Control

@onready var timer = $Timer
@onready var canva = $CanvasLayer

var tempo_segs : int = 0

func _ready() -> void:
	canva.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_paste"):
		Globals.finalizou = true
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
	tempo_segs = 0
	
func _on_timer_timeout() -> void:
	tempo_segs += 1
	var m = int(tempo_segs / 60.0)
	var s = tempo_segs % 60
	%Label.text = '%02d:%02d ' % [m, s]
