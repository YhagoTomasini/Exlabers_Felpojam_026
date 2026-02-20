extends Control

@onready var jogarB : Button = $CanvasLayer/VBoxContainer/Button
@onready var parallax = $ParallaxBG

var intensidade = 30.0
var suavidade = 5.0
var alvo = Vector2.ZERO

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport_rect().size
	
	var offset = (mouse_pos - screen_size / 2.0) / (screen_size / 2.0)
	alvo = offset * intensidade
	parallax.scroll_offset = parallax.scroll_offset.lerp(alvo, delta * suavidade)

func _ready() -> void:
	jogarB.grab_focus()

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Cenas/sala_de_testes.tscn")


func _on_button_2_button_down() -> void:
	get_tree().change_scene_to_file("res://Cenas/tela_creditos.tscn")


func _on_button_3_button_down() -> void:
	get_tree().quit()
