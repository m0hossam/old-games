extends TileMap

var grid = []
var grid_size = 10

func _ready():
	randomize()
	grid.resize(grid_size)
	for i in range(grid_size):
		grid[i] = []
		grid[i].resize(grid_size)
		for j in range(grid_size):
			if i == 0 or i == grid_size-1 or j == 0 or j == grid_size-1:
				grid[i][j] = 0 #grass wall
			else:
				grid[i][j] = randi() % 2 #between 0-1
			
	for i in range(grid_size):
		for j in range(grid_size):
			set_cell(i, j, grid[i][j])

func get_grid_cell(x, y):
	if x < 0 or x >= grid_size or y < 0 or y >= grid_size:
		return null
	return grid[x][y]
