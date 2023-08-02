extends CharacterBody2D
class_name PLAYER

signal player_fired_attack(range_attack, position, direction)


@export var Range_attack: PackedScene

var player_is_attacking

@onready var bodySprite = $CompositeSprites/Body
@onready var handsSprite = $CompositeSprites/Hands
@onready var armorSprite = $CompositeSprites/Armor
@onready var shadowSprite = $CompositeSprites/Shadow
@onready var pantsSprite = $CompositeSprites/Pants
@onready var headSprite = $CompositeSprites/Helmet



@onready var anim = $AnimationPlayer
@onready var wand_attack_point = $Sprites/Wand_attack_point
@onready var attack_cd = $Attack_Cooldown
@onready var player_stats = $Stats


const composite_sprites = preload("res://Scripts/CompositeSpriteSheets/Composite_sprites.gd")

func _ready():
	bodySprite.texture = composite_sprites.body_spritesheet[0]
	handsSprite.texture = composite_sprites.hands_spritesheet[0]
	shadowSprite.texture = composite_sprites.shadow_spritesheet[0]
	headSprite.texture = composite_sprites.head_spritesheet[0]
	armorSprite.texture = composite_sprites.armor_spritesheet[0]
	pantsSprite.texture = composite_sprites.pants_spritesheet[0]

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var position_mouse_x = get_global_mouse_position().x

#	print(player_is_attacking)
	
	if position_mouse_x < global_position.x:
		$Sprites.scale.x = -1
	elif position_mouse_x > global_position.x: 
		$Sprites.scale.x = 1
		
	if player_is_attacking:
		anim.play("Attack")
	elif input_direction:
		velocity = input_direction * player_stats.speed
		anim.play("Run")
	else: 
		velocity = input_direction * 0
		anim.play("Idle")



func _process(delta):
	get_input()
	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("attack_mouse"):
#		player_is_attacking = true
		attack_range()
		
		

func attack_range():
	if attack_cd.is_stopped():
#		if player_is_attacking:
#			player_is_attacking = false
			
		var bullet_instance = Range_attack.instantiate()
		var target = get_global_mouse_position()
		var direction_to_mouse = wand_attack_point.global_position.direction_to(target).normalized()
		emit_signal("player_fired_attack", bullet_instance, wand_attack_point.global_position, direction_to_mouse)
		attack_cd.start()
		



func handle_hit():
	player_stats.health -= 20
	print("player hit ", player_stats.health)
