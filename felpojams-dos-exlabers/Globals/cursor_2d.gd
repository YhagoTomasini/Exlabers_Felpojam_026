extends CanvasLayer

@onready var cursor : Sprite2D = $Sprite2D

func _ready() -> void:
	cor_cursor()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func cor_cursor():
	if Globals.corAtual == 0:
		cursor.self_modulate = Color(0.157, 0.157, 0.267, 1.0)
		
	elif Globals.corAtual == 2:
		cursor.self_modulate = Color(1.0, 0.0, 1.0, 1.0)
		
	elif Globals.corAtual == 1:
		cursor.self_modulate = Color(1.0, 1.0, 0.0, 1.0)
		
	elif Globals.corAtual == 3:
		cursor.self_modulate = Color(0.0, 1.0, 1.0, 1.0)
	
func _process(delta: float) -> void:
	cursor.position = get_viewport().get_mouse_position()
