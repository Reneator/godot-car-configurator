extends HBoxContainer

var extra : Car_Option

func _ready():
	$Label.text = extra.option_name
	$Price.text = "%d Euro" % extra.price
