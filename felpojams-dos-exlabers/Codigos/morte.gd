extends Area2D


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "PersonagemPrincipal":
		print("nome do assassino: " + str(get_groups()))
		body.player_morreu(str(get_groups()))
