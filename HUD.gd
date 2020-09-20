extends CanvasLayer

signal game_over

var full_heart = preload("res://resources/full-heart.png")
var empty_heart = preload("res://resources/empty-heart.png")
var hearts = [$Heart1, $Heart2, $Heart3]
var lives = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_lost_life():
	lives -= 1
	if lives >= 0:
		hearts[lives].set_texture = empty_heart
	if lives < 0:
		emit_signal("game_over")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
