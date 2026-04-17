extends Node2D
@onready var DEBUG_THIS_TILEMAP_NODE = Nodelist.list["oDataWibble"]

var tileDrawDist = 32
var draw_grid = false
var dynamic_font = preload("res://Theme/ClassicConsole.ttf")

#oDataSlx.set_cellv(cursorTile, 4)

func _process(delta):
	if Input.is_action_just_pressed("debug_tilemap") and OS.has_feature("standalone") == false:
		draw_grid = !draw_grid
	queue_redraw()

func _draw():
	if is_instance_valid(DEBUG_THIS_TILEMAP_NODE) == false: return
	if draw_grid == true:
		var font_size = tileDrawDist
		for x in (M.xSize*3): #get_size_x():
			for y in (M.ySize*3): #get_size_y():
				var value = DEBUG_THIS_TILEMAP_NODE.get_cell(x,y)
				var string = str(value)
				var pos = Vector2(x*tileDrawDist, y*tileDrawDist) + Vector2(tileDrawDist*0.5,tileDrawDist*0.5)
				pos.x -= dynamic_font.get_string_size(string, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x * 0.5 # Center string
				pos.y += dynamic_font.get_string_size(string, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).y * 0.25

				pos.x -= 16
				pos.y -= 16

				var color = Color.WHITE
#				match value:
#					0: color = Color.RED
#					1: color = Color.BLUE
#					2: color = Color.GREEN
#					3: color = Color.YELLOW
#					4: color = Color.CADETBLUE
#					5: color = Color.BLACK

				draw_string(dynamic_font, pos, string, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)
