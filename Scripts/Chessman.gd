extends Node2D

export var rank = 0
export var file = 0
var selected = false
var midpointX = 1024/2
var midpointY = 576/2
var size = 60


func _ready():		# When this piece is spawned
	load_piece()		#load the piece

func load_piece():	#Loading function to print piece to the screen
	self.position.x = midpointX + (file-4)*size + (size/2)	#Finds the x axis for the piece's location
	self.position.y = midpointY + (rank-4)*size + (size/2)	#Finds the x axis for the piece's location

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
func file_offset(offset):	#setter function for the chess piece's x axis
		file = file + offset
		load_piece()
func rank_offset(offset):	#setter function for the chess piece's y axis
		rank = rank + offset
		load_piece()
func checkPiece():
	if (rank < 0 or rank > 7 or file < 0 or file > 7):
		self.queue_free()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
		load_piece()
	pass # Replace with function body.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && !event.pressed:
			selected = false
			var tempX = self.position.x
			var tempY = self.position.y
			file = round((tempX-midpointX)/size + 3.5)
			rank = round((tempY-midpointY)/size + 3.5)
			checkPiece()
			load_piece()
#
