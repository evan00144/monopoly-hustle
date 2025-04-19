extends Node

@onready var cells = $BoardContainer.get_children()
var reveal_delay = 1 # seconds between reveals

func _ready():
	# Hide all cells at start
	for cell in cells:
		cell.visible = false
	# Start the reveal animation
	reveal_cells()

func reveal_cells():
	# Coroutine to reveal each cell one by one
	for cell in cells:
		cell.visible = true
		await get_tree().create_timer(reveal_delay).timeout
