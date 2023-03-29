@tool
extends Node2D

class Processor extends Thread:
	signal done()
	@export var force_end = false
	func run():
		start(_run)
	func _run(): pass

var _thread: Processor
@export var in_progress = false:
	get:
		return _thread != null
	set(value):
		if (value && not _thread):
			_thread = Processor.new()
			_thread.done.connect(_finish)
			_thread.run()
		elif (value && _thread) or (!value && not _thread):
			pass
		elif (!value && _thread):
			push_error("Cannot make the thread not in progress.")
		else:
			push_error("If you're reading this, your computer has been hit by a cosmic ray.")

func _finish():
	in_progress = false
	_thread.wait_to_finish()
	_thread = null
