extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("achou o felps anao")
		Achivements._liberar_conquista(5)
