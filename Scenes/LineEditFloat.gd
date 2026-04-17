extends LineEdit

func _ready():
	focus_exited.connect(_on_focus_exited)

func _on_focus_exited():
	text = String(float(text))
	#text = text.pad_decimals(2)
