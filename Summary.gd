extends VBoxContainer

export (PackedScene) var option_element_scene
export (PackedScene) var extra_element_scene

var configuration : Car_Configuration

func _ready():
	$Base_Price/Price.text = "%d Euro" % configuration.base_price
	
	for engine_option in configuration.engines:
		add_option_element("Motorleistung:", engine_option)
	for paintjob in configuration.paintjobs:
		add_option_element("Lackierung:", paintjob)
	for rim in configuration.rims:
		add_option_element("Felgen:",rim)
	for extra in configuration.extras:
		var extra_element = extra_element_scene.instance()
		extra_element.extra = extra
		$Extras.add_child(extra_element)
	
	$Total/Price.text = "%d Euro" % configuration.cached_total

func add_option_element(title, option):
		var option_element = option_element_scene.instance()
		option_element.title = title
		option_element.option = option
		$Options.add_child(option_element)
	
