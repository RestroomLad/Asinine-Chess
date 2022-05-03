extends Node2D

onready var board = [64]
onready var pieces = []
onready var piece = preload("res://Chessman.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.filename)
	
	_draw()
	startingPos()
	massLoad()
	
	pass
func _unhandled_input(e):
	if (e is InputEventKey and e.scancode == KEY_M):
		massLoad()
	elif (e is InputEventKey and e.scancode == KEY_E):
		pieceExtinction()

func _draw():	#Draw the board
	var darkCol = Color8(88, 39, 7)
	var lightCol = Color8(245, 226, 200)
	var size = 60
	var midpointX = 1024/2
	var midpointY = 576/2
	
	for x in range(-4, 4):
		for y in range(-4, 4):
			if (x + y) % 2 == 0:
				draw_rect(Rect2(x*size + midpointX, y*size + midpointY, size, size), lightCol)
			else:
				draw_rect(Rect2(x*size + midpointX, y*size + midpointY, size, size), darkCol)
func startingPos():
	board.resize(64)
	for i in range(0, 64):
		if i == 60: # White King
			board[i] = 0
		elif i == 59: # White Queen
			board[i] = 1
		elif i == 58 or i == 61: # White Bishop
			board[i] = 2
		elif i == 57 or i == 62: # White Horsie
			board[i] = 3
		elif i == 56 || i == 63: # White Rook
			board[i] = 4
		elif 48 <= i && i <= 55: # White Pawn
			board[i] = 5
		elif i == 4: # Black King
			board[i] = 10
		elif i == 3: # Black Queen
			board[i] = 11
		elif i == 2 or i == 5: # Black Bishop
			board[i] = 12 
		elif i == 1 or i == 6: # Black Horsies
			board[i] = 13
		elif i == 0 or i == 7: # Black Rook
			board[i] = 14
		elif 8 <= i && i <= 15: # Black Pawns
			board[i] = 15
		
		
		else:
			board[i] = -1
func handle_checkPiece(piece, startI, endI: int):
	print(startI, " ", board[startI])
	print(endI, " ", board[endI]) 
	
	piece.rank = endI/8
	piece.file = endI % 8
	if board[endI] == -1:
		board[endI] = board[startI]
		board[startI] = -1
	elif board[endI] == 1 && board[startI] == 3:
		board[startI] = -1
		board[endI] = 6
		massLoad()
	else :
		board[endI] = board[startI]
		board[startI] = -1
		massLoad()
	
func pieceExtinction():
	var instance
	while pieces.size() > 0:
		instance = pieces.pop_front()
		instance.queue_free()
func massLoad():
	pieceExtinction()
	for i in range(0, 64):
		if board[i] != -1:
			var instance = piece.instance()
			add_child(instance)
			instance.get_node("Sprite").frame = board[i]
			instance.rank = i/8
			instance.file = i%8
			instance.load_piece()
			instance.connect("checkPiece", self, "handle_checkPiece")
			pieces.push_back(instance)
	piece.connect("checkPiece", self, "handle_checkPiece")


