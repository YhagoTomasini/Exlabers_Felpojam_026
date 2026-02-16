extends Node2D

@onready var cenaMarca = preload("res://Cenas/marca.tscn")

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		var marcaInstanciada = cenaMarca.instantiate()
		marcaInstanciada.global_position = get_local_mouse_position()
		add_child(marcaInstanciada)
	
