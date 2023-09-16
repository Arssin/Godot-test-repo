extends AnimatedSprite2D


@onready var _animated_sprite = $"."


func _process(delta):
	_animated_sprite.play("portal-animation")
	
