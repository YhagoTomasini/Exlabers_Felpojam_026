extends Control

@onready var timer = $Timer
@onready var canva = $CanvasLayer

func _ready() -> void:
	canva.visible = false
		
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
	Globals.salvar_jogo()
	
func _on_timer_timeout() -> void:
	Globals.dados.tempo_segs += 1
	var m = int(Globals.dados.tempo_segs / 60.0)
	var s = Globals.dados.tempo_segs % 60
	%Label.text = '%02d:%02d ' % [m, s]
	Globals.salvar_jogo()
	
	
	
