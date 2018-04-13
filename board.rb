require 'colorize'

class Board
  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @winning_combo = []
  end

  def add_x(position)
    @board[position - 1] = 'X'
  end

  def add_o(position)
    @board[position - 1] = 'O'
  end

  def get_piece(position)
    @board[position - 1]
  end

  def set_winning_combo(array)
    @winning_combo = array
  end

  def example_print
    puts "\n"
    puts '1 | 2 | 3'
    puts '---------'
    puts '4 | 5 | 6'
    puts '---------'
    puts '7 | 8 | 9'
  end

  def print
    puts "\n"
    puts @board[0].to_s + ' | ' + @board[1].to_s + ' | ' + @board[2].to_s
    puts '---------'
    puts @board[3].to_s + ' | ' + @board[4].to_s + ' | ' + @board[5].to_s
    puts '---------'
    puts @board[6].to_s + ' | ' + @board[7].to_s + ' | ' + @board[8].to_s
  end

  def print_winner
    puts "\n"
    row_one = []
    row_two = []
    row_three = []
    i = 0
    while i < 10
      if i < 3
        if @winning_combo.include?(i)
          row_one.push(@board[i].to_s.colorize(:green))
        else
          row_one.push(@board[i].to_s)
        end
      elsif i < 6
        if @winning_combo.include?(i)
          row_two.push(@board[i].to_s.colorize(:green))
        else
          row_two.push(@board[i].to_s)
        end
      elsif i < 9
        if @winning_combo.include?(i)
          row_three.push(@board[i].to_s.colorize(:green))
        else
          row_three.push(@board[i].to_s)
        end
      end
      i += 1
    end
    puts row_one.join(' | ')
    puts '---------'
    puts row_two.join(' | ')
    puts '---------'
    puts row_three.join(' | ')
  end
end
