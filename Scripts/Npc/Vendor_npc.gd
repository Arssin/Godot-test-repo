extends Node2D

@onready var vendor_modal = $"Vendor-Modal"

var player_entered = false

func _process(delta):
	
	if player_entered == true:
		if Input.is_action_just_pressed("enter_clicked"):
			print('Shop Opened')
	


func _on_area_2d_body_entered(body):
	if body.has_method('get_input_soul_player'):
		player_entered = true
		vendor_modal.show()


func _on_area_2d_body_exited(body):
	if body.has_method("get_input_soul_player"):
		player_entered = false
		vendor_modal.hide()
