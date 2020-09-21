extends CanvasLayer

signal game_over
signal new_game
signal start_game
signal menu_screen

var full_heart = preload("res://resources/full-heart.png")
var empty_heart = preload("res://resources/empty-heart.png")
var hearts = []
var lives = 3
var state = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	hearts.append($Heart1)
	hearts.append($Heart2)
	hearts.append($Heart3)
	for heart in hearts:
		heart.hide()

func _on_lost_life():
	lives -= 1
	if lives >= 0:
		hearts[lives].set_texture(empty_heart)
	if lives < 0:
		print("Game Over")
		emit_signal("game_over")
		$Timer.start()

func _on_Timer_timeout():
	for heart in hearts:
		heart.hide()
	$Splash.show()
	$Background.show()
	$Button.show()
	emit_signal("menu_screen")

func _on_new_game():
	for heart in hearts:
		heart.show()
	$Splash.hide()
	$Background.hide()
	$Button.hide()
	lives = 3
	emit_signal("start_game")
