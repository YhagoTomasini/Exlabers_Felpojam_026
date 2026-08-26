extends Control

@export var text : Label
@onready var canva : CanvasLayer = $CanvasLayer
#var dados : SaveInfo

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	canva.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_focus_mode"):
		if !canva.visible:
			canva.visible = true
		else:
			canva.visible = false
		
	var fCount := 0
	for i in Globals.dados.felps_contados:
		if i:
			fCount += 1
	var aCount := 0
	for i in Globals.dados.assassinos_contados:
		if i:
			aCount += 1
			
			
	text.text = (
		"Lvl1: " + str(Globals.dados.conquista[0]) + " | " +
		"Lvl2: " + str(Globals.dados.conquista[1]) + " | " +
		"Lvl3: " + str(Globals.dados.conquista[2]) + "\n" +
		"Finalizou: " + str(Globals.dados.finalizou) + "\n" +
		"Felps achados: " + str(fCount) + str(Globals.dados.conquista[4]) +"\n" +
		"Felps anão: " + str(Globals.dados.conquista[5]) + "\n" +
		"Mortes morridas: " + str(aCount) + str(Globals.dados.conquista[6]) +"\n" +
		"Tela conquista on: " + str(Globals.dados.telaConquistaOn)
	)
