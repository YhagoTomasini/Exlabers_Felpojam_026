extends Node2D

@export var icone : Sprite2D

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	icone.texture = Globals.arrayTintas[Globals.corAtual]
