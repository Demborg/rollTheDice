extends Button


func _on_ShareButton_pressed():
	OS.set_clipboard("demb.org/rollTheDice?seed=%s&state=%s" % [Global.global_seed, Global.encoded_state(3)])
	text = "Copied"
