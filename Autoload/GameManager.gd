extends Node

signal drop_emoji(current_emoji : Dictionary, global_pos : Vector2)
signal combine_emoji(emoji_id : int, pos : Vector2, score : int)
signal check_collision(global_pos : Vector2)

const _1 = preload("res://Assets/1.png")
const _2 = preload("res://Assets/2.png")
const _3 = preload("res://Assets/3.png")
const _4 = preload("res://Assets/4.png")
const _5 = preload("res://Assets/5.png")
const _6 = preload("res://Assets/6.png")
const _7 = preload("res://Assets/7.png")
const _8 = preload("res://Assets/8.png")
const _9 = preload("res://Assets/9.png")
const _10 = preload("res://Assets/10.png")
const _11 = preload("res://Assets/11.png")

var emoji_list : Array = []
var game_over = false

func _ready():
	emoji_list.append({id = 1, score = 1, texture = _1})
	emoji_list.append({id = 2, score = 3, texture = _2})
	emoji_list.append({id = 3, score = 6, texture = _3})
	emoji_list.append({id = 4, score = 10, texture = _4})
	emoji_list.append({id = 5, score = 15, texture = _5})
	emoji_list.append({id = 6, score = 21, texture = _6})
	emoji_list.append({id = 7, score = 28, texture = _7})
	emoji_list.append({id = 8, score = 36, texture = _8})
	emoji_list.append({id = 9, score = 45, texture = _9})
	emoji_list.append({id = 10, score = 56, texture = _10})
	emoji_list.append({id = 11, score = 66, texture = _11})

