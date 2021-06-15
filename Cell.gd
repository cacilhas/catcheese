class_name Cell
extends Spatial

enum {W = 1, E = 2, N = 4, S = 8}

var _free := 0


func can_go(dir: int) -> bool:
	return _free & dir == dir


func remove_walls(walls: int) -> void:
	if walls & W > 0 and not can_go(W):
		$WallW.queue_free()
		_free |= W

	if walls & E > 0 and not can_go(E):
		$WallE.queue_free()
		_free |= E

	if walls & N > 0 and not can_go(N):
		$WallN.queue_free()
		_free |= N

	if walls & S > 0 and not can_go(S):
		$WallS.queue_free()
		_free |= S


func set_color(color: Color) -> void:
	for wall in [$WallE/MeshInstance, $WallN/MeshInstance, $WallS/MeshInstance, $WallW/MeshInstance]:
		if wall:
			var material: SpatialMaterial = wall.get_surface_material(0).duplicate()
			material.albedo_color = color
			wall.set_surface_material(0, material)
