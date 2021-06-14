extends Object

class_name Settings

const STORAGE := "user://settings.json"

export var size := Vector2(10, 10)
export var cheeses := 4
export var best_time := 0 setget set_best_time, get_best_time
export var fullscreen := false
export var bg_color := Color.bisque

var _best_times = {}


func reload() -> void:
	var file := File.new()
	if file.file_exists(STORAGE):
		file.open(STORAGE, File.READ)
		var data := JSON.parse(file.get_as_text())
		file.close()
		if data.result:
			var res := data.result as Dictionary
			var aux_size := _parse_int_vector2(res.get("size", ""))
			size = size if aux_size == Vector2.ZERO else aux_size
			cheeses = res.get("cheeses", cheeses)
			if res.has("best_times"):
				_get_best_times(res.best_times)
			bg_color = Color(res.get("bg_color", bg_color.to_rgba32()) as int)
			fullscreen = res.get("fullscreen", fullscreen)


func save() -> void:
	var file := File.new()
	var data := JSON.print({
		size = size,
		cheeses = cheeses,
		fullscreen = fullscreen,
		best_times = _best_times,
		bg_color = bg_color.to_rgba32(),
	})
	file.open(STORAGE, File.WRITE)
	file.store_string(data)
	file.close()


func get_best_time() -> int:
	var key := Vector3(size.x, size.y, cheeses)
	return _best_times.get(key, 0)


func set_best_time(value: int) -> void:
	var key := Vector3(size.x, size.y, cheeses)
	_best_times[key] = value


func _get_best_times(res: Dictionary) -> void:
	for key in res:
		var vec := _parse_int_vector3(key as String)
		if vec != Vector3.ZERO:
			_best_times[vec] = res[key]


static func _parse_int_vector2(value: String) -> Vector2:
	var data := value.trim_prefix("(").trim_suffix(")").split(",")
	if data.size() == 2:
		var x := int(data[0])
		var y := int(data[1].trim_prefix(" "))
		return Vector2(x, y)
	return Vector2.ZERO


static func _parse_int_vector3(value: String) -> Vector3:
	var data := value.trim_prefix("(").trim_suffix(")").split(",")
	if data.size() == 3:
		var x := int(data[0])
		var y := int(data[1].trim_prefix(" "))
		var z := int(data[2].trim_prefix(" "))
		return Vector3(x, y, z)
	return Vector3.ZERO
