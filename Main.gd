extends Control

onready var http = $HTTPRequest
onready var configurator = $VBoxContainer/Car_Configurator
var configurations = []

func _ready():
	var headers = ["Content-Type: application/json"]
	http.request("http://157.90.116.81:8081/carconfigurator/configs/all")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var body_dict = json.result
	print(body_dict)
	$VBoxContainer/HBoxContainer/OptionButton.clear()
	for car in body_dict:
		var configuration = Car_Configuration.new()
		configuration.from_json(car)
		configurations.append(configuration)
		$VBoxContainer/HBoxContainer/OptionButton.add_item(configuration.car_name)


func _on_OptionButton_item_selected(index):
	var configuration = configurations[index]
	$VBoxContainer/Car_Configurator.configuration = configuration
