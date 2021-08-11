extends Reference
class_name Car_Option

var option_name
var price

func _init(option):
	option_name = option.get("name")
	price = option.get("price")

func get_option_string():
	return "%s (+%d Euro)" % [option_name,price]
