extends Node2D

export var rank = 0
export var file = 0
var board
var selected = false
var midpointX = 1024/2
var midpointY = 576/2
var size = 60
signal checkPiece(piece, startI, endI)

func _ready():		# When this piece is spawned
	board = get_tree().get_root().get_node("Node2D").get_node("Chessboard").board
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
func checkPiece(f, r):
	var startIndex = rank * 8 + file
	var endIndex = r * 8 + f
	if 0 <= f && f < 8 && 0 <= r && r < 8:
		emit_signal("checkPiece", self, startIndex, endIndex)
	load_piece()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
		load_piece()
	pass # Replace with function body.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && !event.pressed && selected:
			selected = false
			print("Let go")
			var tempX = self.position.x
			var tempY = self.position.y
			var tempFile = round((tempX-midpointX)/size + 3.5)
			var tempRank = round((tempY-midpointY)/size + 3.5)
			checkPiece(tempFile, tempRank)
#
