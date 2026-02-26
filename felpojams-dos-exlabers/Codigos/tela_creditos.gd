extends Control

#Literalmente o mesmo código que usei nos créditos de itsy bitsy spider e crysantiun

@export var scroll_container: ScrollContainer

@export var text_node: RichTextLabel
@export var velo : float = 1
var acabou : bool

@export var pause : Control

func _ready() -> void:
	acabou = false
	
func fim():
	acabou = true
	pause.pausar()
	print("fim")
	
func _process(delta: float) -> void:
	if !acabou:
		if scroll_container.scroll_vertical <= text_node.size.y+100:
			scroll_container.scroll_vertical += 1 * velo
			#print(scroll_container.scroll_vertical)
		else:
			#print("sssss")
			fim()
		
		if Input.is_action_pressed("ui_up"):
			velo = 6.0
		else:
			velo = 1.0
