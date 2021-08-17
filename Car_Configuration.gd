extends Reference
class_name Car_Configuration

var car_name
var base_price
var rims = []
var engines = []
var paintjobs = []
var extras = []

var cached_total

func from_json(car_json):
	car_name = car_json.get("name")
	base_price = car_json.get("basePrice")
	var _rims = car_json.get("rims")
	for rim in _rims:
		rims.append(Car_Option.new(rim))
	
	var _engines = car_json.get("engine")
	for engine in _engines:
		engines.append(Car_Option.new(engine))
	
	var _paintjobs = car_json.get("paintjob")
	for paintjob in _paintjobs:
		paintjobs.append(Car_Option.new(paintjob))
	
	var _extras = car_json.get("extras")
	for extra in _extras:
		extras.append(Car_Option.new(extra))
