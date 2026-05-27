@tool
extends EditorPlugin

var mainScreen = ''

func _enter_tree():
	main_screen_changed.connect(main_screen_changed)

func _input(event):
	if event is InputEventMouseButton and (event.is_pressed() and event.button_index == MOUSE_BUTTON_MIDDLE):
		if mainScreen == "Script":
			await get_tree().process_frame # Allows things in script panel to still be closed by middle click
			var ev = InputEventKey.new()
			ev.pressed = true
			ev.keycode = KEY_CONTROL
			get_tree().input_event(ev)

			var evt = InputEventMouseButton.new()
			evt.button_index = MOUSE_BUTTON_LEFT
			evt.position = get_viewport().get_mouse_position()
			evt.pressed = true
			evt.control = true
			get_tree().input_event(evt)
			evt.pressed = false
			get_tree().input_event(evt)

func main_screen_changed(screen):
	mainScreen = screen
