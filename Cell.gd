extends Spatial

class_name Cell

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
