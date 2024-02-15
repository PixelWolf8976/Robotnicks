extends Node2D

# $TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, TILES.Copper), 0)

enum TILES {Copper, Coal, Grass, SandToGrass, Sand, SandToWater, Stone, StoneToGrass, Water}

@export var percentGrass = 0.0
@export var percentSand = 0.0
@export var percentStone = 0.0
@export var PercentWater = 0.0

func _ready():
	randomize()
	generateNoise(Vector2(100, 100))

func generateNoise(gridSize):
	var noiseGen = FastNoiseLite.new()
	noiseGen.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noiseGen.set_frequency(0.04)
	
	for x in range(1, gridSize.x - 1):
		for y in range(1, gridSize.y - 1):
			var layers = [0.05, 0.05, 0.3925, 0.11, 0.3925, 0.11, 0.3925, 0.11, 0.3925]
			var noise = -1
			if noiseGen.get_noise_2d(x, y) < -1 + (layers[0]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 0), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 1), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 6), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2] + layers[3]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 7), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2] + layers[3] + layers[4]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 2), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2] + layers[3] + layers[4] + layers[5]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 3), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2] + layers[3] + layers[4] + layers[5] + layers[6]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 4), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2] + layers[3] + layers[4] + layers[5] + layers[6] + layers[7]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 5), 0)
			elif noiseGen.get_noise_2d(x, y) < -1 + (layers[0] + layers[1] + layers[2] + layers[3] + layers[4] + layers[5] + layers[6] + layers[7] + layers[8]):
				$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, 8), 0)

func generateWaveFunctionCollapse(gridSize):
	# Generate grid
	var tileData = []
	
	# Make grid
	for x in range(gridSize.x):
		var row = []
		for y in range(gridSize.y):
			row.append(-1)
		tileData.append(row)
	
	# Fill first square
	var tileId = 2
	tileData[0][0] = tileId
	$TileMap.set_cell(0, Vector2i(0, 0), 1, Vector2i(0, tileId), 0)
	
	var firstTile = true
	
	for x in range(gridSize.x):
		for y in range(gridSize.y):
			var possibleGrids = [0, 1, 2, 3, 4, 5, 6, 7, 8]
			var weights = [0.07, 0.1, 0.57, 0.25, 0.55, 0.4, 0.53, 0.25, 0.55]
			
			var indexesToRemove = []
			
			if firstTile:
				firstTile = false
				continue
			else:
				# Left Bottom, Left, Left Top, Top
				var neighboringPixels = [-1, -1, -1, -1]
				
				if x - 1 >= 0 && y + 1 < tileData[x].size():
					neighboringPixels[0] = tileData[x - 1][y + 1]
				if x - 1 >= 0:
					neighboringPixels[1] = tileData[x - 1][y]
				if x - 1 >= 0 && y - 1 >= 0:
					neighboringPixels[2] = tileData[x - 1][y - 1]
				if y - 1 >= 0:
					neighboringPixels[3] = tileData[x][y - 1]
				
				for neighbor in neighboringPixels:
					if neighbor != -1:
						if neighbor == 0:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 2 || grid == 3 || grid == 4 || grid == 5 || grid == 7 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 1:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 2 || grid == 3 || grid == 4 || grid == 5 || grid == 7 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 2:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 0 || grid == 1 || grid == 4 || grid == 5 || grid == 6 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 3:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 0 || grid == 1 || grid == 5 || grid == 6 || grid == 7 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 4:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 0 || grid == 1 || grid == 2 || grid == 6 || grid == 7 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 5:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 0 || grid == 1 || grid == 2 || grid == 3 || grid == 6 || grid == 7:
									indexesToRemove.append(index)
						elif neighbor == 6:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 2 || grid == 3 || grid == 4 || grid == 5 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 7:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								if grid == 0 || grid == 1 || grid == 3 || grid == 4 || grid == 5 || grid == 8:
									indexesToRemove.append(index)
						elif neighbor == 8:
							for index in possibleGrids:
								var grid = possibleGrids[index]
								weights[8] *= 1.5
								if grid == 0 || grid == 1 || grid == 2 || grid == 3 || grid == 4 || grid == 6 || grid == 7:
									indexesToRemove.append(index)
			
			# Remove imposible borders
			var unduplicatedExludedIndexes = []
			for i in range(indexesToRemove.size()):
				if not unduplicatedExludedIndexes.has(indexesToRemove[i]):
					unduplicatedExludedIndexes.append(indexesToRemove[i])
			
			# Sorts
			unduplicatedExludedIndexes.sort_custom(greaterThan)
			
			for index in unduplicatedExludedIndexes:
				possibleGrids.remove_at(index)
				weights.remove_at(index)
			
			if len(possibleGrids) <= 0:
				continue
			
			var totalWeight = 0.0
			for weight in weights:
				totalWeight += weight
			weights = weights.map(func(x): return x / totalWeight)
			
			var weightedSelection = weighted_random_choice(possibleGrids, weights)
			tileId = weightedSelection
			tileData[x][y] = tileId
			$TileMap.set_cell(0, Vector2i(x, y), 1, Vector2i(0, tileId), 0)

func weighted_random_choice(choices, weights):
	var total = 0.0
	for weight in weights:
		total += weight
	var threshold = randf() * total
	var sum = 0.0
	for i in range(choices.size()):
		sum += weights[i]
		if sum >= threshold:
			return choices[i]
	
	return choices[-1]  # Return the last choice if threshold is not reached

func greaterThan(a, b):
	return a > b
