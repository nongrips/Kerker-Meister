extends Window
#onready var oUnearthVerLabel = Nodelist.list["oUnearthVerLabel"]
@onready var oMain = Nodelist.list["oMain"]
@onready var oAboutGridContainer = Nodelist.list["oAboutGridContainer"]

func _ready():
	for i in oAboutGridContainer.get_children():
		if i is LinkButton:
			i.pressed.connect(on_link_clicked.bind(i))

func on_link_clicked(id):
	OS.shell_open(id.text)


func _on_AboutWindow_about_to_show():
	#if is_instance_valid(oMain) == false: return
	#oUnearthVerLabel.text = 
	title = 'Unearth v'+Version.full

