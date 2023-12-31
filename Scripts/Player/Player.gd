extends CharacterBody2D
class_name PLAYER

signal player_fired_attack(range_attack, position, direction)


@export var Range_attack: PackedScene

var player_attack_in_progress = false

@onready var bodySprite = $CompositeSprites/Body
@onready var handsSprite = $CompositeSprites/Hands
@onready var armorSprite = $CompositeSprites/Armor
@onready var shadowSprite = $CompositeSprites/Shadow
@onready var pantsSprite = $CompositeSprites/Pants
@onready var headSprite = $CompositeSprites/Helmet


@onready var anim = $AnimationPlayer
@onready var wand_attack_point = $WeaponSprites/Wand_attack_point
@onready var attack_cd = $Attack_Cooldown
@onready var player_stats = PlayerStats


func _ready():
	player_stats.player_health = $Stats.player_health
	bodySprite.texture = $CompositeSprites.body_spritesheet[0]
	handsSprite.texture = $CompositeSprites.hands_spritesheet[0]
	shadowSprite.texture = $CompositeSprites.shadow_spritesheet[0]
	headSprite.texture = $CompositeSprites.head_spritesheet[0]
	armorSprite.texture = $CompositeSprites.armor_spritesheet[0]
	pantsSprite.texture = $CompositeSprites.pants_spritesheet[0]

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var position_mouse_x = get_global_mouse_position().x
	
	if position_mouse_x < global_position.x:
		$CompositeSprites.scale.x = -1
		$CollisionPolygon2D.scale.x = -1
		$WeaponSprites.scale.x = -1
	elif position_mouse_x > global_position.x: 
		$CompositeSprites.scale.x = 1
		$CollisionPolygon2D.scale.x = 1
		$WeaponSprites.scale.x = 1
		
		
	if attack_cd.is_stopped():
		if Input.is_action_just_pressed("attack_mouse"):
			attack_range()
			# Ten fragment jest do przemyślenia więcej na githubie	
			# velocity = input_direction * 0
			# anim.play("Attack")
		else:
			Global.player_current_attack = false
			player_attack_in_progress = false

	if input_direction and anim.current_animation != "Attack":
		velocity = input_direction * player_stats.player_speed
		anim.play("Run")
	elif anim.current_animation != "Attack": 
		velocity = input_direction * 0
		anim.play("Idle")
		
		



func _process(delta):
	get_input()
	handle_player_dead()
	update_player_healthbar()
	move_and_slide()


func attack_range():
	Global.player_current_attack = true
	player_attack_in_progress = true
	var bullet_instance = Range_attack.instantiate()
	var target = get_global_mouse_position()
	var direction_to_mouse = wand_attack_point.global_position.direction_to(target).normalized()
	emit_signal("player_fired_attack", bullet_instance, wand_attack_point.global_position, direction_to_mouse)
	attack_cd.start()


func handle_player_dead():
	if player_stats.player_health <= 0:
		print('Player Dead')
		get_tree().reload_current_scene()
		get_tree().change_scene_to_file("res://Scenes/Levels/youre_dead.tscn")
		

func update_player_healthbar():
	var healthbar = $PlayerHealthbar
	healthbar.value = player_stats.player_health


