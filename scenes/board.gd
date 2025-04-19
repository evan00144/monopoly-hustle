extends Node3D

const BOARD_SIZE = 10
const SMALL_CELL_SIZE = Vector3(2, 0.2, 1.5)
const BIG_CELL_SIZE = Vector3(2, 0.2, 2)

var SmallCellScene = preload("res://scenes/cell.tscn")
var BigCellScene = preload("res://scenes/cell-big.tscn")

func _ready():
	generate_board()


func generate_board():
	var positions = []
	var rotations = []
	var current_position = Vector3.ZERO
	var position_adder = ((BIG_CELL_SIZE.x/2) + (SMALL_CELL_SIZE.z/2) + 0.2)
	print(BIG_CELL_SIZE.x)
	print(SMALL_CELL_SIZE.z)
	print(position_adder)
	# Top Row
	for i in range(BOARD_SIZE):
		var pos = current_position
		if i == 0 or i == 1 or i == BOARD_SIZE - 1:
			pos.z += position_adder if i > 0 else 0
		else:
			pos.z += SMALL_CELL_SIZE.z +0.2
		current_position = pos
		positions.append(pos)
		rotations.append(Vector3(0, deg_to_rad(0), 0))

	# Right Column
	for i in range(1, BOARD_SIZE):
		var pos = current_position
		if i == 1:
			pos.x += position_adder
		elif (i == BOARD_SIZE - 1):
			pos.x += position_adder
		else:
			pos.x += SMALL_CELL_SIZE.z + 0.2
		current_position = pos
		positions.append(pos)
		rotations.append(Vector3(0, deg_to_rad(90), 0))

	# Bottom Row (reverse)
	for i in range(1, BOARD_SIZE):
		var pos = Vector3(current_position.x, 0, positions[BOARD_SIZE - 1 - i].z)
		current_position = pos
		positions.append(pos)
		rotations.append(Vector3(0, deg_to_rad(180), 0))

	# Left Column (reverse)
	for i in range(1, BOARD_SIZE - 1):
		var pos = Vector3(positions[BOARD_SIZE * 2 - 2 - i].x, 0, current_position.z)
		current_position = pos
		positions.append(pos)
		rotations.append(Vector3(0, deg_to_rad(270), 0))

	# Instantiate cells
	for i in positions.size():
		var is_big = i == 0 or i % (BOARD_SIZE - 1) == 0
		var cell = BigCellScene.instantiate() if is_big else SmallCellScene.instantiate()
		cell.transform.origin = positions[i]
		cell.rotation = rotations[i]
		add_child(cell)

		# Floating text label
		var label = Label3D.new()
		label.text = "Cell %d" % i
		label.position = Vector3(0, 1.2, 0)
		cell.add_child(label)

	print(positions)
