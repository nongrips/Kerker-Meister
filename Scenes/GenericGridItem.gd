extends PanelContainer

signal pressed

var img_normal:

	set(_val): set_image_normal(_val)
var img_pressed
var img_hover
var img_margin = 0
var orig_backcol

func _ready():
	if img_normal:
		$TextureRect.texture = img_normal
	orig_backcol = get_stylebox("panel").bg_color
	
	
	get_stylebox("panel").content_margin_left = img_margin
	get_stylebox("panel").content_margin_right = img_margin
	get_stylebox("panel").content_margin_top = img_margin
	get_stylebox("panel").content_margin_bottom = img_margin

func _on_GenericGridItem_mouse_entered():
	if img_hover:
		$TextureRect.texture = img_hover
	
	get_stylebox("panel").bg_color = orig_backcol * 1.25

func _on_GenericGridItem_mouse_exited():
	if img_normal:
		$TextureRect.texture = img_normal
	
	get_stylebox("panel").bg_color = orig_backcol

func _on_GenericGridItem_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true:
				if img_pressed:
					$TextureRect.texture = img_pressed
				pressed.emit()
				for i in 20:
					await get_tree().process_frame
				_on_GenericGridItem_mouse_exited()


func set_image_normal(setVal):
	$TextureRect.texture = setVal
	img_normal = setVal
