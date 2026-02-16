extends Node2D

@export var simbulo : Sprite2D

var alpha : float

func _ready() -> void:
		if Globals.corAtual == 0:
			if Globals.tanqueTintaPreta < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaPreta / Globals.maxTanque
				print(alpha, Globals.tanqueTintaPreta)
				simbulo.self_modulate = Color()
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaPreta -= 1
			
		elif Globals.corAtual == 1:
			if Globals.tanqueTintaMagenta < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaMagenta / Globals.maxTanque
				print(alpha, Globals.tanqueTintaMagenta)
				simbulo.self_modulate = Color(1.0, 0.0, 1.0, 1.0)
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaMagenta -= 1
			
		elif Globals.corAtual == 2:
			if Globals.tanqueTintaAmarelo < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaAmarelo / Globals.maxTanque
				print(alpha, Globals.tanqueTintaAmarelo)
				simbulo.self_modulate = Color(1.0, 1.0, 0.0, 1.0)
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaAmarelo -= 1
			
		elif Globals.corAtual == 3:
			if Globals.tanqueTintaCiano < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaCiano / Globals.maxTanque
				print(alpha, Globals.tanqueTintaCiano)
				simbulo.self_modulate = Color(0.0, 1.0, 1.0, 1.0)
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaCiano -= 1

	
