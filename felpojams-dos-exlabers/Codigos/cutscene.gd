extends Control

@export var botao_pular : Button

func _ready():
	AudioManager.vol_som(2, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.vol_som(2, SoundEffect.TIPO_DE_SOM.TEMA2)
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.CUTSCENE)
	
	#Transição.anim_out()
	
	botao_pular.visible = false
	await get_tree().create_timer(3.5).timeout
	botao_pular.visible = true
	botao_pular.grab_focus()
	


 
func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://Cenas/lvl_1.tscn")

func _on_button_pressed() -> void:
	AudioManager.destruir_todos_aud(SoundEffect.TIPO_DE_SOM.CUTSCENE)
	get_tree().change_scene_to_file("res://Cenas/lvl_1.tscn")
