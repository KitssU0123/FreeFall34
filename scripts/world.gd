extends Node2D

@onready var platforms = $Platforms
const Platforms = preload("res://scripts/platforms.gd")

func _ready():
	# 獲取關卡配置
	var level_config = Platforms.new()
	
	# 獲取第一關的平台配置
	var current_level = level_config.levels[0]
	
	# 計算平台之間的間距
	var total_width = 248 - 40
	var platform_count = platforms.get_child_count()
	
	var spacing = total_width / (platform_count - 1)
	
	# 遍歷所有平台並設置類型和位置
	for i in range(platform_count):
		var platform = platforms.get_child(i)
		platform.sprite_2d.frame = current_level[i]
		# 設置平台的x位置
		platform.position.x = 40 + (spacing * i)
		platform.position.y = 120




func _on_area_2d_body_entered(body: Node2D) -> void:
	print("die")
	get_tree().reload_current_scene()
