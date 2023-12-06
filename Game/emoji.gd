extends RigidBody2D
class_name Emoji

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

var emoji : Dictionary
var can_combine : bool = true

func _ready():
	sprite.texture = emoji.texture
	sprite.scale = Vector2(0.043, 0.043) * (1 + (emoji.id - 1) * 0.4)
	collision.scale = Vector2.ONE * (1 + (emoji.id - 1) * 0.4)
	mass = (1 + (emoji.id - 1) * 0.4)
	can_combine = true

func _process(_delta):
	#Just in case the emoji gets out of boundary
	if global_position.y > 1000:
		queue_free()

func _on_body_entered(body):
	if is_queued_for_deletion():
		return
	if body is Emoji:
		GameManager.check_collision.emit((self.global_position + body.global_position) / 2 )
		if body.emoji.id == self.emoji.id:
			if emoji.id + 1 != 12:
				var midpoint = (self.global_position + body.global_position) / 2 
				body.queue_free()
				GameManager.combine_emoji.emit(emoji.id + 1, midpoint, emoji.score)
				self.queue_free()
