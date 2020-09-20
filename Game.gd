extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Level.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_CanvasLayer_menu_screen():
	$Level.hide()

func _on_CanvasLayer_start_game():
	$Level.show()
