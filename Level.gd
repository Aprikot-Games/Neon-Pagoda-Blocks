extends Node2D

export (PackedScene) var TowerRigidBody

var tower = []
var current_block
var available = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$TowerBlock.set_collision_layer_bit(1, false)
	$TowerBlock.set_collision_mask_bit(0, false)
	tower.append($TowerBase)

func _on_drop_block():
	if $TowerBlock.visible == true:
		# Create a block to drop onto the tower
		var new_block = TowerRigidBody.instance()
		add_child(new_block)
		new_block.position = $TowerBlock.position
		new_block.connect("block_ready", self, "_on_block_ready")
		$TowerBlock.hide()
		current_block = new_block
		available = false

func shift_landscape():
	var tween = get_node("Back1/Tween")
	tween.interpolate_property($Back1, "position",
			Vector2($Back1.position.x, $Back1.position.y), 
			Vector2($Back1.position.x, $Back1.position.y + 90), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween = get_node("Back2/Tween")
	tween.interpolate_property($Back2, "position",
			Vector2($Back2.position.x, $Back2.position.y), 
			Vector2($Back2.position.x, $Back2.position.y + 67.5), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween = get_node("Back3/Tween")
	tween.interpolate_property($Back3, "position",
			Vector2($Back3.position.x, $Back3.position.y), 
			Vector2($Back3.position.x, $Back3.position.y + 45), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func shift_block(block):
	var tween = block.get_node("Tween")
	tween.interpolate_property(block, "position",
			Vector2(block.position.x, block.position.y), 
			Vector2(block.position.x, block.position.y + 90), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_block_ready(res):
	print("End of drop")
	if res == 0:
		tower.append(current_block)
		# Shift the whole tower down
		for block in tower:
			if block != null:
				shift_block(block)
		shift_landscape()
		print(tower)
		$BlockTimer.start()
	elif res == 1: # Falling block
		$TowerBlock.show()
	elif res == 2: # Old block
		tower.pop_front()

func _on_BlockTimer_timeout():
	$TowerBlock.show()
