extends Sprite2D

@export var n : int

var onScreen := [false, false, false, false]
var ja_contou : bool = false

func _on_visible_1_screen_entered() -> void:
	onScreen[0] = true
	full_onScreen()
func _on_visible_2_screen_entered() -> void:
	onScreen[1] = true
	full_onScreen()
func _on_visible_3_screen_entered() -> void:
	onScreen[2] = true
	full_onScreen()
func _on_visible_4_screen_entered() -> void:
	onScreen[3] = true
	full_onScreen()


func _on_visible_1_screen_exited() -> void:
	onScreen[0] = false
func _on_visible_2_screen_exited() -> void:
	onScreen[1] = false
func _on_visible_3_screen_exited() -> void:
	onScreen[2] = false
func _on_visible_4_screen_exited() -> void:
	onScreen[3] = false


func full_onScreen() -> void:
	if ja_contou:
		return
		
	if onScreen.all(func(v): return v):
		print("testeaaaaaaaaaaaaaa")
		ja_contou = true
		Globals.felpses_counter(n)
