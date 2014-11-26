
##################################################################
##                                                              ##
## By Andrew Miksch for the Flatiron School application process.##
##                                                              ##
##################################################################

#'Tictactoe' uses a 9 element array to store the moves on the board.
# The game starts with X and switches after every valid turn.
# The game ends when @game_over == true.

class Tictactoe
	def initialize
		@moves = [" "," "," "," "," "," "," "," "," "]
		# 0 1 2
		# 3 4 5
		# 6 7 8
		@mark = "X"
		@game_over = false
		@number_of_rounds = 0
	end

	def play

		#Run round until @game_over is true.
		while @game_over == false
			round(@moves, @mark)
			#Check the winner method after each round.
			winner(@moves, @mark)
			#Check if there are any unused spaces on the board
			#and return a draw if there are not.
			open = @moves.count(" ")
			if open == 0
				display_board(@moves)
				puts "The game is a draw!"
				puts "Would you like to play again? (Y/N)"
				play_again
				@game_over = true
			end
			turn_change
		end

	end
	def display_board(board)
		#displays the board
		puts ""
		puts "   A   B   C"
		puts "1  #{board[0]} | #{board[1]} | #{board[2]} "
		puts "  -----------"
		puts "2  #{board[3]} | #{board[4]} | #{board[5]} "
		puts "  -----------"
		puts "3  #{board[6]} | #{board[7]} | #{board[8]} "
		puts ""
		puts ""
	end

	def round(board, player)
		#Each round starts by displaying the board, reqesting coordinates
		#and comparing the coordinates to the 9 valid options. If the value given
		#matches one of the 9 valid options, the player value is stored in the
		#board array. It sends a string to the error method if the value received
		#is off the board or is already in use.

		display_board(board)
		puts "It's #{@mark}'s turn!"
		puts "Which colume would you like to mark? (A, B, C)"
		turn = gets.chomp.capitalize
		puts "Which row would you like to mark? (1, 2, 3)"
		turn << gets.chomp
		mark_board = {
				"A1" => 0,
				"B1" => 1,
				"C1" => 2,
				"A2" => 3,
				"B2" => 4,
				"C2" => 5,
				"A3" => 6,
				"B3" => 7,
				"C3" => 8
			}
		if mark_board.has_key?(turn)
			if board[mark_board[turn]] == " "
				board[mark_board[turn]] = player
				@number_of_rounds += 1
			else
				error("taken")
			end
		else
			error("off")
		end

	end


	def turn_change
		#Changes who's turn it is
		if @mark == "X"
			@mark = "O"
		else
			@mark = "X"
		end
	end

	def error(condition)
		#Tile selected is off the board
		if condition ==  "off"
			puts ""
			puts "Invalid input. Please try again."
			puts ""
			turn_change #This changes the turn so the turn remains correct after
						#going through the while loop.
		end
		#Tile selected has already been used
		if condition == "taken"
			puts ""
			puts "That square is already taken. Please try again."
			puts ""
			turn_change #This changes the turn so the turn remains correct after
						#going through the while loop.
		end
	end

	def winner(board, player)
		#Compares the 3 values necessary for victory against the current user's turn.
		#Top row victory
		if  board[0] == player and board[1] == player and board[2] == player
			victory
		#Middle row victory
		elsif board[3] == player and board[4] == player and board[5] == player
			victory
		#Bottom row victory
		elsif board[6] == player and board[7] == player and board[8] == player
			victory
		#Left column victory	
		elsif board[0] == player and board[3] == player and board[6] == player
			victory
		#Middle column victory
		elsif board[1] == player and board[4] == player and board[7] == player
			victory
		#Right column victory
		elsif board[2] == player and board[5] == player and board[8] == player
			victory
		#Top left to bottom right victory
		elsif board[0] == player and board[4] == player and board[8] == player
			victory
		#Top right to bottom left victory
		elsif board[2] == player and board[4] == player and board[6] == player
			victory
		end																			
	end

	def play_again
		answer = gets.chomp.capitalize
		#Start a new game
		if answer == "Y"
			puts ""
			puts ""
			puts ""
			puts "---NEW GAME---"			
			play
		#Quit
		elsif answer == "N"
			puts "--------------------------"
			puts "| Thank you for playing! |"
			puts "--------------------------"
		else
			puts "Invalid response."
			puts "Would you like to play again? (Y/N)"
			play_again
		end
	end
				

	def victory
		#Display that the game is over.
		puts ""
		puts ""
		display_board(@moves)
		puts ""
		puts "#{@mark} has won the game in #{@number_of_rounds} turns!"
		puts ""
		puts ""
		@game_over = true
		puts "Would you like to play again? (Y/N)"
		play_again
	end		
end



#run the game
Tictactoe.new.play
















