extends Object
class_name Utility

static func ok(e: int) -> void:
	if e != OK:
		print_debug("Error: %s" % e)

static func stfu(_ignore) -> void: pass

static func indexV(position: Vector2, width: int) -> int:
	return index(int(position.x), int(position.y), width)

static func index(x: int, y: int, width: int) -> int:
	return int(y * width + x)

static func position(index: int, width: int) -> Vector2:
	var y := int(index / float(width))
	var x := int(index - width * y)
	return Vector2(x, y)

static func range(value: int, count: int) -> Array:
	var array := []
	for i in range(count):
		array.append(value + i)
	return array

static func repeat(value, count: int) -> Array:
	var array := []
	for _i in range(count):
		array.append(value)
	return array

static func priority(d: Dictionary) -> Object:
	var o
	var total := 0
	for value in d.values():
		total += value
	var selected := Random.next(total)
	var current := 0
	for key in d.keys():
		o = key
		current += d[key]
		if current > selected:
			break
	return o
