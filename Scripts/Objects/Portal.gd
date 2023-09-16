extends AnimatedSprite2D


@onready var _animated_sprite = $Portal_sprite


func _process(delta):
	_animated_sprite.play("portal-animation")
	


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
