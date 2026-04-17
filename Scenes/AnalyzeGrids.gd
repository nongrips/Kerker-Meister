extends Node2D

@onready var oDataWibble = Nodelist.list["oDataWibble"]
@onready var oDataLiquid = Nodelist.list["oDataLiquid"]
@onready var oDataSlab = Nodelist.list["oDataSlab"]
@onready var oDataOwnership = Nodelist.list["oDataOwnership"]
@onready var oDataClmPos = Nodelist.list["oDataClmPos"]
@onready var oDataFakeSlab = Nodelist.list["oDataFakeSlab"]
@onready var oDataSlx = Nodelist.list["oDataSlx"]
@onready var oGridDataCheckBox1 = Nodelist.list["oGridDataCheckBox1"]
@onready var oGridDataCheckBox2 = Nodelist.list["oGridDataCheckBox2"]
@onready var oGridDataCheckBox3 = Nodelist.list["oGridDataCheckBox3"]
@onready var oGridDataCheckBox4 = Nodelist.list["oGridDataCheckBox4"]
@onready var oGridDataCheckBox5 = Nodelist.list["oGridDataCheckBox5"]
@onready var oGridDataCheckBox6 = Nodelist.list["oGridDataCheckBox6"]
@onready var oGridDataCheckBox7 = Nodelist.list["oGridDataCheckBox7"]
@onready var oGridDataWindow = Nodelist.list["oGridDataWindow"]
@onready var oCamera2D = Nodelist.list["oCamera2D"]

@onready var tilemap_data = {
	"Wibble":           {"extension": ".wib", "grid_type": "SUBTILE", "node": oDataWibble},
	"Liquid":           {"extension": ".wlb", "grid_type": "TILE",    "node": oDataLiquid},
	"Slab":             {"extension": ".slb", "grid_type": "TILE",    "node": oDataSlab},
	"Ownership":        {"extension": ".own", "grid_type": "SUBTILE", "node": oDataOwnership},
	"Column Positions": {"extension": ".dat", "grid_type": "SUBTILE", "node": oDataClmPos},
	"Fake Slabs":       {"extension": ".une", "grid_type": "TILE",    "node": oDataFakeSlab},
	"Style":            {"extension": ".slx", "grid_type": "TILE",    "node": oDataSlx}
}

var currentlySelected = ""

var dynamic_font = preload("res://Theme/ClassicConsole.ttf")

func _ready():
	set_process(false)

	oGridDataCheckBox1.pressed.connect(_on_checkbox.bind(oGridDataCheckBox1,"Slab"))
	oGridDataCheckBox2.pressed.connect(_on_checkbox.bind(oGridDataCheckBox2,"Ownership"))
	oGridDataCheckBox3.pressed.connect(_on_checkbox.bind(oGridDataCheckBox3,"Column Positions"))
	oGridDataCheckBox4.pressed.connect(_on_checkbox.bind(oGridDataCheckBox4,"Wibble"))
	oGridDataCheckBox5.pressed.connect(_on_checkbox.bind(oGridDataCheckBox5,"Liquid"))
	oGridDataCheckBox6.pressed.connect(_on_checkbox.bind(oGridDataCheckBox6,"Style"))
	oGridDataCheckBox7.pressed.connect(_on_checkbox.bind(oGridDataCheckBox7,"Fake Slabs"))

func _on_checkbox(checkboxNodeThatWasPressed, pressedString):
	for i in [oGridDataCheckBox1, oGridDataCheckBox2, oGridDataCheckBox3, oGridDataCheckBox4, oGridDataCheckBox5, oGridDataCheckBox6, oGridDataCheckBox7]:
		i.add_theme_color_override("font_color", Color("40ffffff"))
	checkboxNodeThatWasPressed.add_theme_color_override("font_color", Color("40ffffff"))
	
	currentlySelected = pressedString


func _on_GridDataWindow_visibility_changed():
	if is_instance_valid(oGridDataWindow) == false: return
	if oGridDataWindow.visible == true:
		set_process(true)
		await get_tree().process_frame
		oGridDataWindow.position.x = 0
	else:
		queue_redraw()
		set_process(false)

var frame_counter = 0

func _process(delta):
	frame_counter += 1
	if frame_counter >= 30:
		queue_redraw()
		frame_counter = 0

func _draw():
	if currentlySelected == "" or oGridDataWindow.visible == false:
		return

	var node = tilemap_data[currentlySelected]["node"]
	var grid_type = tilemap_data[currentlySelected]["grid_type"]
	var value
	var pos
	var factor
	if grid_type == "TILE":
		factor = 1
	else:
		factor = 3
	var tileDrawDist = 96/factor
	var font_size = 18 if currentlySelected == "Column Positions" else 36

	var half_tileDrawDist = tileDrawDist * 0.5

	var offsetTilePos = Vector2(half_tileDrawDist, half_tileDrawDist)
	if currentlySelected == "Wibble":
		offsetTilePos = Vector2(0,0)

	var viewport_size = get_viewport_rect().size
	var screen_start = oCamera2D.get_camera_screen_center() - (viewport_size * 0.5) * oCamera2D.zoom
	var screen_end = oCamera2D.get_camera_screen_center() + (viewport_size * 0.5) * oCamera2D.zoom

	for x in range(max(0, floor(screen_start.x / tileDrawDist)), min(M.xSize * factor, ceil(screen_end.x / tileDrawDist))):
		for y in range(max(0, floor(screen_start.y / tileDrawDist)), min(M.ySize * factor, ceil(screen_end.y / tileDrawDist))):
			if currentlySelected == "Style":
				value = oDataSlx.slxImgData.get_pixel(x,y).r8
			else:
				value = node.get_cell(x,y)
			var string = str(value)

			pos = Vector2(x * tileDrawDist, y * tileDrawDist) + offsetTilePos
			var stringSize = dynamic_font.get_string_size(string, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
			pos += Vector2(-stringSize.x * 0.5, stringSize.y * 0.25) # Center string
			draw_string(dynamic_font, pos, string, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, Color(1, 1, 1, 1))
