extends Node2D
#onready var oLoadImages = $'LoadImages'
#onready var oMain = $'..'
#
#var tex = {}
#var files = []
#var directories = []
#
##onready var oLoadImages = $'LoadImages'
#
#var CODETIME_START
#func _ready():
#	get_dir_contents("dk_images")
#
#	CODETIME_START = OS.get_ticks_msec()
#	loadimages(files)
#	#oLoadImages.start(files)
#	print('Textures loaded from HDD '+str(OS.get_ticks_msec()-CODETIME_START)+'ms')
#	#oMain.acontinue()
#
#func loadimages(files):
#	for i in files.size():
#		var img = Image.new()
#		var imgTex = ImageTexture.new()
#
#		img.load(files[i])
#		imgTex.set_image(img)
#
#		#print(files[i])
#
#		tex[files[i]] = imgTex
#
##func done(tex):
##	oMain.acontinue()
#
#var baseDir
#func get_dir_contents(rootPath: String):
#	var dir = DirAccess.new()
#	if dir.open(rootPath) == OK:
#		dir.list_dir_begin()
#		baseDir = dir.get_current_dir().get_base_dir() + "/"
#		_add_dir_contents(dir)
#	else:
#		push_error("An error occurred when trying to access the path.")
#
#func _add_dir_contents(dir: Directory):
#	var file_name = dir.get_next()
#
#	while (file_name != ""):
#		var path = dir.get_current_dir() + "/" + file_name
#
#		if dir.current_is_dir():
#			var subDir = DirAccess.new()
#			subDir.open(path)
#			subDir.list_dir_begin()
#			directories.append(path)
#			_add_dir_contents(subDir)
#		else:
#			if path.ends_with(".png"):
#				path = path.replace(baseDir,"") #Remove base directory
#				files.append(path)
#
#		file_name = dir.get_next()
#
#	dir.list_dir_end()
