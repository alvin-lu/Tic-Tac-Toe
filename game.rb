require_relative 'board.rb'
require_relative 'player.rb'

require 'os'

# TODO: make sure gems are properly installed prior to running application
# TODO: determine OS since clear only works on UNIX/Linux system
# system('cls') for windows-based systems
# TODO: fix winning combo if multiple solutions were found

class Game
  def initialize
    @is_windows = OS.windows?
    # clearning screen
    if @is_windows
      system('cls')
    else
      print %x{clear}
    end
    
    # Gathering player data
    puts 'Player one, what is your name'
    player_one_name = gets.chomp
    puts 'Player two, what is your name'
    player_two_name = gets.chomp

    # Game setup
    @player_one = Player.new(player_one_name, 'O')
    @player_two = Player.new(player_two_name, 'X')
    @board = Board.new
    @current_player = @player_one

    # Game info
    puts "\nTic-Tac-Toe is a game where you take turns placing a piece in respect to you as a player"
    puts 'and to win you are able to have three pieces of your own in a row.'
    puts '(i.e. 1 - 5 - 9)'
    @board.example_print

    not_ready = true
    while not_ready
      puts "\nReady to start? (Y/N)"
      user_input = gets.chomp.downcase
      not_ready = false if user_input == 'y'
    end

    game_logic
  end

  def game_logic
    turn = 1
    game_not_ended = true
    while game_not_ended
      if @is_windows
        system('cls')
      else
        print %x{clear}
      end
      @board.example_print
      @board.print
      puts "\nTurn: " + turn.to_s
      set_move

      if winner? || ended_in_tie?(turn)
        if ended_in_tie?(turn)
          if @is_windows
            system('cls')
          else
            print %x{clear}
          end
          @board.print
          puts "\nGame ended in tie"
        else
          if @is_windows
            system('cls')
          else
            print %x{clear}
          end
          @board.print_winner
          puts "\n" + @current_player.get_name + ' is the winner!'
        end
        game_not_ended = false
      end

      # Switches to the other player
      if @current_player == @player_one
        @current_player = @player_two
      elsif @current_player == @player_two
        @current_player = @player_one
      end
      turn += 1
    end
  end

  def set_move
    position = ''
    not_valid = true
    while not_valid
      puts "\n" + @current_player.get_name + ', where would you like to play your ' + @current_player.get_piece + '?'
      position = gets.chomp
      not_valid = !valid_move?(position)
    end

    if @current_player.get_piece == 'O'
      @board.add_o(position.to_i)
    elsif @current_player.get_piece == 'X'
      @board.add_x(position.to_i)
    end
  end

  def valid_move?(position)
    if position.to_i >= 1 && position.to_i <= 9
      return true if @board.get_piece(position.to_i) == ' '
    end
    false
  end

  def winner?
    game_piece = @current_player.get_piece
    # Horizontal
    if (@board.get_piece(1) == game_piece) && (@board.get_piece(2) == game_piece) && (@board.get_piece(3) == game_piece)
      @board.set_winning_combo([0, 1, 2])
      return true
    elsif (@board.get_piece(4) == game_piece) && (@board.get_piece(5) == game_piece) && (@board.get_piece(6) == game_piece)
      @board.set_winning_combo([3, 4, 5])
      return true
    elsif (@board.get_piece(7) == game_piece) && (@board.get_piece(8) == game_piece) && (@board.get_piece(9) == game_piece)
      @board.set_winning_combo([6, 7, 8])
      return true
    # Vertical
    elsif (@board.get_piece(1) == game_piece) && (@board.get_piece(4) == game_piece) && (@board.get_piece(7) == game_piece)
      @board.set_winning_combo([0, 3, 6])
      return true
    elsif (@board.get_piece(2) == game_piece) && (@board.get_piece(5) == game_piece) && (@board.get_piece(8) == game_piece)
      @board.set_winning_combo([1, 4, 7])
      return true
    elsif (@board.get_piece(3) == game_piece) && (@board.get_piece(6) == game_piece) && (@board.get_piece(9) == game_piece)
      @board.set_winning_combo([2, 5, 8])
      return true
    # Diagonal
    elsif (@board.get_piece(1) == game_piece) && (@board.get_piece(5) == game_piece) && (@board.get_piece(9) == game_piece)
      @board.set_winning_combo([0, 4, 8])
      return true
    elsif (@board.get_piece(3) == game_piece) && (@board.get_piece(5) == game_piece) && (@board.get_piece(7) == game_piece)
      @board.set_winning_combo([2, 4, 6])
      return true
    end
    false
  end

  def ended_in_tie?(turn)
    return true if turn == 9 && !winner?
    false
  end
end
