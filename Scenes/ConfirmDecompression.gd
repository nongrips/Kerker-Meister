extends Window
@onready var oCheckBoxAlwaysDecompress = Nodelist.list["oCheckBoxAlwaysDecompress"]
@onready var oOpenMap = Nodelist.list["oOpenMap"]
@onready var labelText: Label = $VBoxContainer/CompressionWindowLabel
@onready var alwaysDecompressCheckbox: CheckBox = $VBoxContainer/CompressionWindowCheckBox
@onready var CompressionWindowButtonYes: Button = $VBoxContainer/HBoxContainer/CompressionWindowButtonYes
@onready var CompressionWindowButtonNo: Button = $VBoxContainer/HBoxContainer/CompressionWindowButtonNo

func _ready():
	about_to_popup.connect(_on_about_to_show)
	
	# Safe signal connections with null checks
	if CompressionWindowButtonYes:
		CompressionWindowButtonYes.pressed.connect(_on_confirm_pressed)
	
	if CompressionWindowButtonNo:
		CompressionWindowButtonNo.pressed.connect(_on_cancel_pressed)

func set_dialog_text(text: String):
	if labelText:
		labelText.text = text
		# Trigger resize after text change
		call_deferred("_resize_to_content")

func _resize_to_content():
	await get_tree().process_frame
	await get_tree().process_frame  # Extra frame to ensure layout is calculated
	
	var vbox = $VBoxContainer
	if not vbox:
		return
	
	# Let the VBoxContainer calculate its natural size
	await get_tree().process_frame
	
	# Get the VBoxContainer's minimum required size instead of current size
	var content_size = vbox.get_minimum_size()
	
	# Add padding for window borders and title bar
	var window_padding = Vector2(20, 40)  # 10px margin on each side, ~30px for title bar
	var dialog_size = content_size + window_padding
	
	# Ensure minimum size
	dialog_size.x = max(dialog_size.x, 420)
	dialog_size.y = max(dialog_size.y, 150)
	
	# Set the dialog size
	size = dialog_size

func _on_about_to_show():
	alwaysDecompressCheckbox.pressed = oCheckBoxAlwaysDecompress.pressed
	if oCheckBoxAlwaysDecompress.pressed == true: # Check if we should auto-confirm
		# Auto-confirm and hide dialog
		confirmed.emit()
		hide()
		return
	
	await get_tree().process_frame
	# Set minimum size for proper text wrapping calculation
	custom_minimum_size = Vector2(420, 150)
	_resize_to_content()
	CompressionWindowButtonYes.grab_focus()

func _on_confirm_pressed():
	oCheckBoxAlwaysDecompress.pressed = alwaysDecompressCheckbox.pressed
	confirmed.emit()
	hide()

func _on_cancel_pressed():
	hide()

func _input(event):
	if visible == false: 
		return
	if event is InputEventKey and event.pressed == true:
		if get_viewport().gui_get_focus_owner() is LineEdit: 
			return  # If typing some text into somewhere
		match event.keycode:
			KEY_Y:
				CompressionWindowButtonYes.pressed.emit()
			KEY_N:
				CompressionWindowButtonNo.pressed.emit()
			KEY_ESCAPE:
				CompressionWindowButtonNo.pressed.emit()

# Define the confirmed signal for compatibility
signal confirmed 
