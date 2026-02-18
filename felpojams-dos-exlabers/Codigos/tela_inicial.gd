extends Control

@onready var jogarB : Button = $VBoxContainer/Button

func _ready() -> void:
	jogarB.grab_focus()

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Cenas/sala_de_testes.tscn")


func _on_button_2_button_down() -> void:
	get_tree().change_scene_to_file("res://Cenas/tela_creditos.tscn")


func _on_button_3_button_down() -> void:
	get_tree().quit()
