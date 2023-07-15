extends Node2D



func _on_quitbtn_pressed():
	get_tree().quit()



func _on_playbtn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/town_scene.tscn")
