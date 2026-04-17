extends MenuButton
@onready var oPreferencesWindow = Nodelist.list["oPreferencesWindow"]

var dropdown = get_popup()
#PopupMenu
func _ready():
	dropdown.index_pressed.connect(index_pressed)
	dropdown.index_pressed.connect(oPreferencesWindow.menu_msaa_index_pressed)
	dropdown.add_item("MSAA disabled",0)
	dropdown.add_item("MSAA 2x",1)
	dropdown.add_item("MSAA 4x",2)
	dropdown.add_item("MSAA 8x",3)
	dropdown.add_item("MSAA 16x",4)

func index_pressed(index):
	text = dropdown.get_item_text(index)
