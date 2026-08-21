extends Control

@export var a_n : Array[Button]

func _ready() -> void:
	for i in range(a_n.size()):
		if !Globals.dados.conquista.get(i, false):
			var icon : Sprite2D = a_n[i].get_child(0)
			if icon:
				icon.texture = preload("res://Imagens/carimbos/preto.png")



func _on_a_1_mouse_entered() -> void:
	Achivements.display(0)
func _on_a_2_mouse_entered() -> void:
	Achivements.display(1)
func _on_a_3_mouse_entered() -> void:
	Achivements.display(2)
func _on_a_4_mouse_entered() -> void:
	Achivements.display(3)
func _on_a_5_mouse_entered() -> void:
	Achivements.display(4)
	
func _on_a_1_mouse_exited() -> void:
	Achivements.reset_anim()
func _on_a_2_mouse_exited() -> void:
	Achivements.reset_anim()
func _on_a_3_mouse_exited() -> void:
	Achivements.reset_anim()
func _on_a_4_mouse_exited() -> void:
	Achivements.reset_anim()
func _on_a_5_mouse_exited() -> void:
	Achivements.reset_anim()
