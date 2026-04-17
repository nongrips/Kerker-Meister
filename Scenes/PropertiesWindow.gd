extends Window
@onready var oPropertiesTabs = Nodelist.list["oPropertiesTabs"]
@onready var oUniversalDetails = Nodelist.list["oUniversalDetails"]
@onready var oGridFunctions = Nodelist.list["oGridFunctions"]
@onready var oSelectionStatus = Nodelist.list["oSelectionStatus"]
@onready var oUi = Nodelist.list["oUi"]
@onready var vboxContainer = $VBoxContainer

var rectChangedTimer = Timer.new()

func _ready():
	get_close_button().expand = true
	get_close_button().hide()
	item_rect_changed.connect(rect_changed_start_timer)
	rectChangedTimer.timeout.connect(oUi._on_any_window_was_modified.bind(self))
	rectChangedTimer.one_shot = true
	add_child(rectChangedTimer)
	
	gui_input.connect(oGridFunctions._on_GridWindow_gui_input.bind(self))
	
	oPropertiesTabs.current_tab = 0
	oSelectionStatus.visible = false

func _on_PropertiesTabs_item_rect_changed():
	oPropertiesTabs.item_rect_changed.disconnect(_on_PropertiesTabs_item_rect_changed)
	var contentSize = vboxContainer.get_minimum_size()
	size = contentSize + Vector2(0,12)
	oPropertiesTabs.item_rect_changed.connect(_on_PropertiesTabs_item_rect_changed)

#func _on_PropertiesTabs_tab_changed(tab):
#	pass # Replace with function body.

func rect_changed_start_timer():
	rectChangedTimer.start(0.2)
