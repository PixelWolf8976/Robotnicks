extends Node2D

# $TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, tileId), 0)

var tile_size = 25

func _ready():
	generate(Vector2(10, 10))

func generate(gridSize):
	# Generate grid
	var tileData = ([])
	
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
			
			# Left, Right, Up, Down
			var neighboringPixels = [-1, -1, -1, -1]
			
			if x - 1 > 0:
				neighboringPixels[0] = tileData[x - 1][y]
			if x + 1 < gridSize.x:
				neighboringPixels[1] = tileData[x + 1][y]
			if y - 1 > 0:
				neighboringPixels[2] = tileData[x][y - 1]
			if y + 1 < gridSize.y:
				neighboringPixels[3] = tileData[x][y + 1]
			
			for neighbor in neighboringPixels:
				if neighbor == -1:
					continue
				else:
					if neighbor == 0:
						for idk in range(6):
							for index in range(neighboringPixels.size()):
								if index == 2 || index == 3 || index == 4 || index == 5 || index == 7 || index == 8:
									possibleGrids.remove_at(index)
									break
					elif neighbor == 1:
						for idk in range(6):
							for index in range(neighboringPixels.size()):
								if index == 2 || index == 3 || index == 4 || index == 5 || index == 7 || index == 8:
									possibleGrids.remove_at(index)
									break
					elif neighbor == 2:
						for idk in range(6):
							for index in range(neighboringPixels.size()):
								if index == 0 || index == 1 || index == 4 || index == 5 || index == 6 || index == 8:
									possibleGrids.remove_at(index)
									break
