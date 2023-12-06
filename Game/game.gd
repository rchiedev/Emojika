extends Node2D

var score : int = 0
@onready var score_counter = %ScoreCounter
@onready var left_max = $LeftMax

@onready var game_over_screen = %GameOverScreen
@onready var final_score = %FinalScore
@onready var new_game_button = %NewGame
@onready var game_over_sound = $GameOverSound

@onready var emoji_spawner = $EmojiSpawner

@onready var next_emoji_sprite = %NextEmojiSprite

var current_emoji : Dictionary
var next_emoji : Dictionary

func _ready():
	GameManager.check_collision.connect(check_collision)
	
	score = 0
	score_counter.text = str(score)
	game_over_screen.visible = false
	GameManager.game_over = false
	
	current_emoji = get_emoji()
	set_current_emoji()
	
	next_emoji = get_emoji()
	set_next_emoji()

func add_score(value : int):
	score += value
	score_counter.text = str(score)

func check_collision(collision_pos : Vector2):
	if collision_pos.y < left_max.global_position.y and !GameManager.game_over:
		GameManager.game_over = true
		game_over_sound.play()
		
		game_over_screen.visible = true
		final_score.text = "Score : " + str(score)
		
		await get_tree().create_timer(2).timeout
		new_game_button.visible = true
	
func _on_new_game_pressed():
		var _status = get_tree().call_deferred("reload_current_scene")

func get_emoji():
	var index = randi_range(0, 4)
	return GameManager.emoji_list[index]

func set_current_emoji():
	emoji_spawner.current_emoji = current_emoji
	emoji_spawner.set_bubble()

func set_next_emoji():
	next_emoji_sprite.texture = next_emoji.texture
	next_emoji_sprite.scale = Vector2(0.2, 0.2) * (1 + (next_emoji.id - 1) * 0.4)

func on_current_emoji_dropped():
	current_emoji = next_emoji
	set_current_emoji()
	
	await get_tree().create_timer(0.5).timeout
	next_emoji = get_emoji()
	set_next_emoji()
