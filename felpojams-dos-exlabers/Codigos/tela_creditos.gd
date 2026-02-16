extends Control

@export var scroll_container: ScrollContainer

@export var text_node: RichTextLabel
@export var velo : float = 1
var acabou : bool

func _ready() -> void:
	acabou = false
	
func fim():
	acabou = true
	print("fim")
	
	
func _process(delta: float) -> void:
	if scroll_container.scroll_vertical <= text_node.size.y+680:
		scroll_container.scroll_vertical += 1 * velo
	elif !acabou:
		fim()
