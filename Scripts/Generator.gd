extends Node2D

# $TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, tileId), 0)

var tile_size = 25

func _ready():
	generate(Vector2(100, 100))

func generate(gridSize):
	# Generate grid
	var tileData = []
	
	# Make grid
	for x in range(gridSize.x):
		var row = []
		for y in range(gridSize.y):
			row.append(-1)
		tileData.append(row)
	
	# Fill first square
	var tileId = randi() % 9
	tileData[0][0] = tileId
	$TileMap.set_cell(0, Vector2i(0, 0), 1, Vector2i(0, tileId), 0)
	
	for x in range(gridSize.x):
		for y in range(gridSize.y):
			var possibleGrids = [0, 1, 2, 3, 4, 5, 6, 7, 8]
			var indexesToRemove = []
			
			# Left, Up
			var neighboringPixels = [-1, -1]
			
			if x - 1 >= 0:
				neighboringPixels[0] = tileData[x - 1][y]
			if y - 1 >= 0:
				neighboringPixels[1] = tileData[x][y - 1]
			
			for neighbor in neighboringPixels:
				if neighbor == -1:
					continue
				else:
					if neighbor == 0:
						possibleGrids.remove_at(0) # Need to do
					elif neighbor == 1:
						possibleGrids.remove_at(1)
					elif neighbor == 2:
						possibleGrids.remove_at(2)
					elif neighbor == 3:
						possibleGrids.remove_at(3)
					elif neighbor == 4:
						possibleGrids.remove_at(4)
					elif neighbor == 5:
						possibleGrids.remove_at(5)
					elif neighbor == 6:
						possibleGrids.remove_at(6)
					elif neighbor == 7:
						possibleGrids.remove_at(7)
					elif neighbor == 8:
						possibleGrids.remove_at(8)
			
			if len(possibleGrids) <= 0:
				continue
			
			tileId = possibleGrids[randi() % len(possibleGrids)]
			tileData[x][y] = tileId
			print(tileId)
			$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, tileId), 0)

