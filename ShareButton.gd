extends Button


func _on_ShareButton_pressed():
	OS.set_clipboard("demb.org/rollTheDice?seed=%s" % Global.global_seed)
