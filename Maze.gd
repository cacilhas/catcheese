extends Spatial

export(PackedScene) var Cell
export(Script) var C


func _ready():
	randomize()
	var cells := {}
	for y in range(-10, 10, 2):
		for x in range(-10, 10, 2):
			var color := _calculate_color(x/10.0, y/10.0)
			var cell: Cell = Cell.instance()
			cell.set_color(color)
			add_child(cell)
			cell.translate(Vector3(x, 0, y))
			cells[Vector2(5 + x/2, 5 + y/2)] = cell
	_generate_maze(cells, Vector2(10, 10))


func _calculate_color(x: float, y: float) -> Color:
	var color := Color.blue * (x + 1) / 2
	if y >= 0:
		color += Color.red * (y + 1) / 2
	else:
		color += Color.yellow * (-y)
	return color


func _generate_maze(cells: Dictionary, size: Vector2) -> void:
	var cur := Vector2.ZERO
	var visited := {cur: true}
	var track := []

	while visited.values().size() <= cells.size():
		var cur_cell: Cell = cells[cur]
		var candidates := []
		for neighbour in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
			var aux: Vector2 = cur + neighbour
			if 0 <= aux.x and aux.x < size.x and 0 <= aux.y and aux.y < size.y and not visited.get(aux):
				candidates.append(neighbour)

		if candidates.empty():
			if track.empty():
				break
			cur = track.pop_back()

		else:
			var candidate: Vector2 = candidates[randi() % candidates.size()]
			var nxt := cur + candidate
			var next_cell: Cell = cells[nxt]

			match candidate:
				Vector2.UP:
					cur_cell.remove_walls(C.N)
					next_cell.remove_walls(C.S)
				Vector2.DOWN:
					cur_cell.remove_walls(C.S)
					next_cell.remove_walls(C.N)
				Vector2.LEFT:
					cur_cell.remove_walls(C.W)
					next_cell.remove_walls(C.E)
				Vector2.RIGHT:
					cur_cell.remove_walls(C.E)
					next_cell.remove_walls(C.W)

			track.push_back(cur)
			cur = nxt
			visited[cur] = true
