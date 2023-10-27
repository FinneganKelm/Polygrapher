extends Node3D

var targetAngle=0.0
var targetAxis=0

var realvalue

func _on_go_pressed():
	targetAngle = deg_to_rad(realvalue)


func _on_option_button_item_selected(index):
	targetAxis=index



func _on_spin_box_value_changed(value):
	realvalue = value

func _process(delta):
	$Camera3D.position.x = 3-$UI/HSlider.value+1.5
	
	rotation.x = lerp(rotation.x,0.0,0.02)
	rotation.y = lerp(rotation.y,0.0,0.02)
	rotation.z = lerp(rotation.z,0.0,0.02)
	
	match targetAxis:
		0:
			rotation.x = lerp(rotation.x,targetAngle,0.04)
		1:
			rotation.y = lerp(rotation.y,targetAngle,0.04)
		2:
			rotation.z = lerp(rotation.z,targetAngle,0.04)



	
