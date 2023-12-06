extends Node2D

var emoji_scene = preload("res://Game/emoji.tscn")

@onready var combine_sound = $CombineSound

func _ready():
	GameManager.combine_emoji.connect(combine_emoji)
	GameManager.drop_emoji.connect(drop_emoji)

func _process(_delta):
	#Just in case the game exploded :)
	if get_child_count() > 100:
		get_tree().quit()

func drop_emoji(current_emoji : Dictionary, global_pos: Vector2):
	
	var emoji = emoji_scene.instantiate()
	emoji.emoji = current_emoji
	emoji.global_position = global_pos
	
	call_deferred("add_child", emoji)

func combine_emoji(emoji_id : int, pos : Vector2, score : int):
	get_parent().add_score(score)
	
	var emoji = emoji_scene.instantiate()
	emoji.emoji = GameManager.emoji_list[emoji_id - 1]
	emoji.global_position = pos
	
	call_deferred("add_child", emoji)
	combine_sound.play()
