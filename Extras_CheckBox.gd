extends CheckBox
class_name Extras_CheckBox

var option: Car_Option

func initialize(_option):
	option = _option
	text = option.get_option_string()

func get_price():
	return option.price
