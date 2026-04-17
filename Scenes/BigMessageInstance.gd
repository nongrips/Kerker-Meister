extends AcceptDialog

func _ready():
	await get_tree().process_frame
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed():
	if visible == false:
		queue_free()
