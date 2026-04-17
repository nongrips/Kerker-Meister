extends HBoxContainer

@export var label_setting:String:

	get: return get_label_setting()

	set(_val): set_label_setting(_val)
@export var min_value:float:
	get: return get_min_value()
	set(_val): set_min_value(_val)
@export var max_value:float:
	get: return get_max_value()
	set(_val): set_max_value(_val)
@export var step:float:
	get: return get_step()
	set(_val): set_step(_val)
@export var value:float:
	get: return get_value()
	set(_val): set_value(_val)
signal sliderChanged

func _ready():
	$"VBoxContainer/LabelNumber".text = str($"VBoxContainer/HSlider".value)

func _on_HSlider_value_changed(val):
	$"VBoxContainer/LabelNumber".text = str(val)
	sliderChanged.emit()

func set_label_setting(val):
	$LabelSetting.text = val
func get_label_setting():
	return $LabelSetting.text

func set_min_value(val):
	$"VBoxContainer/HSlider".min_value = float(val)
func get_min_value():
	return $"VBoxContainer/HSlider".min_value

func set_max_value(val):
	$"VBoxContainer/HSlider".max_value = float(val)
func get_max_value():
	return $"VBoxContainer/HSlider".max_value

func set_step(val):
	$"VBoxContainer/HSlider".step = float(val)
func get_step():
	return $"VBoxContainer/HSlider".step

func set_value(val):
	$"VBoxContainer/HSlider".value = float(val)
func get_value():
	return $"VBoxContainer/HSlider".value
