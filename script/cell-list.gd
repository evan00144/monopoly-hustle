extends Node
class_name CellsList

# == Data Classes ==
class Player:
	var id: String
	var name: String
	var cell_ownership: Array = []

	func _init(_id: String, _name: String):
		id = _id
		name = _name
		cell_ownership = []

class Game:
	var id: String
	var board_id: String

	func _init(_id: String, _board_id: String):
		id = _id
		board_id = _board_id

class Board:
	var id: String
	var cell_list: Array = []

	func _init(_id: String, _cell_list: Array):
		id = _id
		cell_list = _cell_list

class Cell:
	var id: String
	var name: String
	var cell_type: String
	var price: int
	var rent: int
	var owner: int = -1

	func _init(_id: String, _name: String, _type: String, _price: int = 0, _rent: int = 0):
		id = _id
		name = _name
		cell_type = _type
		price = _price
		rent = _rent

# == Main Variables ==
var cells: Array = []

# == UUID Helper ==
func _generate_uuid() -> String:
	var uuid = str(randi())
	while _uuid_exists(uuid):
		uuid = str(randi())
	return uuid

func _uuid_exists(uuid: String) -> bool:
	for cell in cells:
		if cell.id == uuid:
			return true
	return false

# == Initialization ==
func _ready():
	generate_cells()
	var board_node = get_parent().get_node("board")
	board_node.generate_board(cells)

# == Cell Generator ==
func generate_cells():
	cells.clear()
	
	var cell_definitions = [
		["Go", "corner"],
		["Mediterranean Avenue", "property", 60, 2],
		["Community Chest", "community_chest"],
		["Baltic Avenue", "property", 60, 4],
		["Income Tax", "tax", 200],
		["Reading Railroad", "railroad", 200],
		["Oriental Avenue", "property", 100, 6],
		["Chance", "chance"],
		["Vermont Avenue", "property", 100, 6],
		["Connecticut Avenue", "property", 120, 8],
		["Jail / Just Visiting", "corner"],
		["St. Charles Place", "property", 140, 10],
		["Electric Company", "utility", 150],
		["States Avenue", "property", 140, 10],
		["Virginia Avenue", "property", 160, 12],
		["Pennsylvania Railroad", "railroad", 200],
		["St. James Place", "property", 180, 14],
		["Community Chest", "community_chest"],
		["Tennessee Avenue", "property", 180, 14],
		["New York Avenue", "property", 200, 16],
		["Free Parking", "corner"],
		["Kentucky Avenue", "property", 220, 18],
		["Chance", "chance"],
		["Indiana Avenue", "property", 220, 18],
		["Illinois Avenue", "property", 240, 20],
		["B&O Railroad", "railroad", 200],
		["Atlantic Avenue", "property", 260, 22],
		["Ventnor Avenue", "property", 260, 22],
		["Water Works", "utility", 150],
		["Marvin Gardens", "property", 280, 24],
		["Go To Jail", "corner"],
		["Pacific Avenue", "property", 300, 26],
		["North Carolina Avenue", "property", 300, 26],
		["Community Chest", "community_chest"],
		["Pennsylvania Avenue", "property", 320, 28],
		["Short Line", "railroad", 200],
		["Chance", "chance"],
		["Park Place", "property", 350, 35],
		["Luxury Tax", "tax", 100],
		["Boardwalk", "property", 400, 50],
	]

	for cell_data in cell_definitions:
		var name = cell_data[0]
		var type = cell_data[1]
		var price = cell_data[2] if cell_data.size() > 2 else 0
		var rent = cell_data[3] if cell_data.size() > 3 else 0
		cells.append(Cell.new(_generate_uuid(), name, type, price, rent))
