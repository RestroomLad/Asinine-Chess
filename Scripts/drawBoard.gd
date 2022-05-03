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
		if 8 <= i && i <= 15 :
			board[i] = 15
		elif 48 <= i && i <= 55:
			board[i] = 5
		elif i == 56 || i == 63:
			board[i] = 4
		else:
			board[i] = -1
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
			pieces.push_back(instance)


