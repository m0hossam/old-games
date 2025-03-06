extends TileMap

var grid = []
var grid_size = 10

onready var tilemap = get_parent().get_child(0)

func _ready():
	randomize()
	grid.resize(grid_size)
	for i in range(grid_size):
		grid[i] = []
		grid[i].resize(grid_size)
		for j in range(grid_size):
			grid[i][j] = 1
			if tilemap.get_grid_cell(i, j) != null:
				if tilemap.get_grid_cell(i, j) == 1:
					grid[i][j] = randi() % 2 #between 0-1

	for i in range(grid_size):
		for j in range(grid_size):
			set_cell(i, j, grid[i][j])
			
