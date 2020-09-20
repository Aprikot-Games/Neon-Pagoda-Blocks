extends Node2D

export (PackedScene) var TowerRigidBody
signal lost_life

var tower = []
var current_block
var available = true
var backs

# Called when the node enters the scene tree for the first time.
func _ready():
	backs = [$Back5, $Back4, $Back3, $Back2, $Back1]
	$TowerBlock.set_collision_layer_bit(1, false)
	$TowerBlock.set_collision_mask_bit(0, false)
	tower.append($TowerBase)
	#$Button.hide()

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
	var c = 0
	for back in backs:
		print(backs)
		var tween = back.get_node("Tween")
		tween.interpolate_property(back, "position",
				Vector2(back.position.x, back.position.y), 
				Vector2(back.position.x, back.position.y + 35+(c*4)), 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		c+=1

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
		emit_signal("lost_life")
	elif res == 2: # Old block
		tower.pop_front()

func _on_BlockTimer_timeout():
	$TowerBlock.show()

func _on_game_over():
	$TowerBlock.hide()
	$Button.hide()
