extends Node2D

@onready var range_attack_manager = $Player/Range_attack_manager
@onready var player: PLAYER = $Player/Player



func _ready():
	player.connect("player_fired_attack", Callable(range_attack_manager, "handle_range_attack_spawned"))


