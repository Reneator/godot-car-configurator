extends HBoxContainer

var title
var option : Car_Option

func _ready():
	$Label.text = title
	$Name.text = option.option_name
	$Price.text = "+ %d Euro" % option.price
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
