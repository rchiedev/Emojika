extends StaticBody2D

@onready var marker_2d = $Marker2D
@onready var left_max = $"../LeftMax"
@onready var right_max = $"../RightMax"

@onready var bubble_emoji = $Bubble/BubbleEmoji

@onready var hand = $Hand
@onready var bubble = $Bubble
@onready var hand_hold = preload("res://Assets/Hand-Hold.png")
@onready var hand_open = preload("res://Assets/Hand-Open.png")
@onready var cooldown = $Cooldown

var current_emoji : Dictionary
var can_drop_emoji : bool = true

func _process(_delta):
	global_position.x = clamp(get_global_mouse_position().x, left_max.global_position.x, right_max.global_position.x)
	if Input.is_action_just_pressed("ui_click") and can_drop_emoji and !GameManager.game_over:
		drop_emoji()

func set_bubble():
	bubble_emoji.texture = current_emoji.texture
	bubble_emoji.scale = Vector2(0.2, 0.2) * (1 + (current_emoji.id - 1) * 0.4)

func drop_emoji():
	GameManager.drop_emoji.emit(current_emoji, marker_2d.global_position)
	get_parent().on_current_emoji_dropped()
	
	hand.texture = hand_open
	bubble.visible = false
	can_drop_emoji = false
	
	cooldown.start()

func _on_cooldown_timeout():
	hand.texture = hand_hold
	bubble.visible = true
	can_drop_emoji = true
	current_emoji = get_parent().current_emoji
