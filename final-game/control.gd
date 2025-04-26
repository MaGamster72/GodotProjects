extends Control
func _input(event):
	if event.is_action_pressed("shoot"):
		get_tree().change_scene_to_file("res://main.tscn")

func _process(delta):
	if not $Music.playing:
		$Music.play()
