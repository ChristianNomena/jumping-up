extends Node2D


func _ready():
	camera_set_limit()

#func _process(delta):
#	pass

func camera_set_limit():
	var zone = $Map/TileMap.get_used_rect()
	var cells_size = $Map/TileMap.cell_size
	
	$Hero/Camera2D.limit_left = zone.position.x * cells_size.x
	$Hero/Camera2D.limit_top = zone.position.y * cells_size.y
	$Hero/Camera2D.limit_right = (zone.size.x + zone.position.x) * cells_size.x
	$Hero/Camera2D.limit_bottom = (zone.size.y + zone.position.y) * cells_size.y
