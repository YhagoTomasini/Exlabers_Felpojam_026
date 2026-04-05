extends Node2D

@export var a_n : Array[Button]

func _ready() -> void:
	for i in range(a_n.size()):
		if !Globals.dados.conquista.get(i, false):
			a_n[i].visible = false
