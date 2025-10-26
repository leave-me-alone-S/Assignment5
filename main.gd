extends Control

#define some constants of the code, so that they cannot be easily modified.
const CELL_EMPTY = ""
const CELL_X = "X"
const CELL_O = "O"

#prepare the buttons at the beginning of the game
@onready var buttons = $Button.get_children()
@onready var restart_button = $RestartButton
@onready var label = $Menu/Label
@onready var menu_panel = $Menu

#define the variances and the board(empty).
var current_player 
var board

func _ready():
	menu_panel.visible = false
	current_player = CELL_X
	board = [ 
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		]
	restart_button.pressed.connect(_on_restart_pressed)
	
	# bind the click input signal to the button. pressed is a built-in 	signal. Count the numver of the clicks.
	var button_index = 0
	for button in buttons:		
		button.connect("pressed", on_button_click.bind(button_index, button))
		button_index += 1

#Turn the index of the buttons into rows and columes. 		
func on_button_click(_idx, button):
	if button.text != CELL_EMPTY:
		return
		
	var X = floor(_idx / 3)
	var Y = floor(_idx % 3)
	
	if board[X][Y] == CELL_EMPTY:
		button.text = current_player
		board[X][Y] = current_player
		button.disabled = true
		#Check if the game ends
		set_game_over()
		# Make the players take turns.	
		if current_player == CELL_X:
			current_player = CELL_O 
		else:
			current_player = CELL_X
			
func set_game_over():
		#check win conditions
		if check_win():
			var winner = CELL_O if current_player == CELL_O else CELL_X
			$Menu/Label.text = (winner + "has won!")
			$Menu.visible = true
			
		elif check_full_board():
		#Draw
			$Menu/Label.text = ("Draw!")
			$Menu.visible = true
		
func check_win():
	for i in range(3):
	#check it horizontally
		if board[i][0] != CELL_EMPTY and board[i][0] == board[i][1] and board[i][1] == board[i][2]:
			return true
	for col in range(3):
	##check it vertically
		if board[0][col] != CELL_EMPTY and board[0][col] == board[1][col] and board[1][col] == board[2][col]:
			return true
	#check it diagnally
	if 	board[0][0]	!= CELL_EMPTY and board[0][0] == board[1][1] and board[1][1] == board[2][2]:
		return true
	if board[0][2] != CELL_EMPTY and  board[0][2] == board[1][1] and board[1][1] == board[2][0]:
		return true
	return false

# check the row first and then the columes to see if there is empty field.	
func check_full_board():
	for row in board:
		for col in row:
			if col == CELL_EMPTY:
				return false
		return true
#This line is to return an opposite result of "there is empty field", which means there is no.
	
func _on_restart_pressed():
	current_player = CELL_X
	board = [ 
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		]
	for button in $Button.get_children():
		button.text = ""
		button.disabled = false
	menu_panel.visible = false
	$Menu/Label.text = ""
	
		
		
		


		
	
