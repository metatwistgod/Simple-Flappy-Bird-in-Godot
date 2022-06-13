extends Node

func foo():
	return("bar")

func _ready() -> void:
	var a = funcref(self, "foo")
	print(a.call_func())
