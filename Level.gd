extends Node2D

export (PackedScene) var TowerRigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stack = []
var currentBlock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_drop_block():
	# Create a block to drop onto the tower
	var new_block = TowerRigidBody.instance()
	add_child(new_block)
	new_block.position = $TowerBlock.position
	new_block.connect("body_entered", self, "_on_TowerBlock_body_entered")

func _on_block_ready():
	print("End")
