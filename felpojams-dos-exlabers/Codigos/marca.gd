extends Node2D

#Eu fiz esse código para criar tds as marcas de uma vez só,
#ai lembrei q elas teriam propriedades diferentes e tive que criar uma cena para cada...
# masssss (por preguiça) deixei só esse código para cada cena de marca
#q ai pelo menos a cor delas e a transparencia são definidas pelo msm código...

#ainda não fiz o tinta pula pula, se ela precisar de um codigo proprio colocar em algum filho e não no pai para n tirar esse codigo, agradecido :D
@export var simbulo : Sprite2D

var alpha : float

func _ready() -> void:
		#Essa marca é instanciada pelo código carimbo,
		#ao ser instanciada ela irá verificar qual cor que é para ela ser
		#vai definir a sua cor, a sua transparencia baseada no tanque de tinta da cor em questão
		#e diminuir o estoque de tinta em 1
		#além disso se o tanque estiver em 0 (ou menos) ele vai se deletar automaticamente
		if Globals.corAtual == 0:
			if Globals.tanqueTintaPreta < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaPreta / Globals.maxTanque
				print(alpha, "-", Globals.tanqueTintaPreta)
				simbulo.self_modulate = Color()
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaPreta -= 1
			
		elif Globals.corAtual == 2:
			if Globals.tanqueTintaMagenta < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaMagenta / Globals.maxTanque
				print(alpha, "-", Globals.tanqueTintaMagenta)
				simbulo.self_modulate = Color(1.0, 0.0, 1.0, 1.0)
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaMagenta -= 1
			
		elif Globals.corAtual == 1:
			if Globals.tanqueTintaAmarelo < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaAmarelo / Globals.maxTanque
				print(alpha, "-", Globals.tanqueTintaAmarelo)
				simbulo.self_modulate = Color(1.0, 1.0, 0.0, 1.0)
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaAmarelo -= 1
			
		elif Globals.corAtual == 3:
			if Globals.tanqueTintaCiano < 1:
				queue_free()
			else:
				alpha = Globals.tanqueTintaCiano / Globals.maxTanque
				print(alpha, "-", Globals.tanqueTintaCiano)
				simbulo.self_modulate = Color(0.0, 1.0, 1.0, 1.0)
				simbulo.modulate = Color(1.0, 1.0, 1.0, alpha)
				Globals.tanqueTintaCiano -= 1
			
