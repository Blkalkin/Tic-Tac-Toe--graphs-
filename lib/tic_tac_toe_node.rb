require_relative 'tic_tac_toe'


class TicTacToeNode

  attr_reader :board, :prev_move_pos, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def children
    children = []
    #p board.open_positions
    board.open_positions.each do |pos|
      if board.empty?(pos)
        dup_board = board.dup
        dup_board[pos] = next_mover_mark
        
        next_mover_mark == :x ? new_mover_mark = :o : new_mover_mark = :x

        children << TicTacToeNode.new(dup_board,new_mover_mark,pos)
      end
    end
    children
  end

  def losing_node?(evaluator)
    return true if board.winner && board.winner != evaluator 
    if evaluator == next_mover_mark
      return true if children.all? { |child| child.losing_node?(evaluator)}
    end
    if evaluator != next_mover_mark
      return true if children.any? { |child| child.losing_node?(evaluator)}
    end
    false
  end

  def winning_node?(evaluator)
    if board.over? 
      if board.winner == evaluator
        return true
      end
      return false
    end
    if evaluator == next_mover_mark
      return true if children.any? { |child| child.winning_node?(evaluator)}
    end
    if evaluator != next_mover_mark
      return true if children.all? { |child| child.winning_node?(evaluator)}
    end
    false
  end

  
end

#node = TicTacToeNode.new(Board.new, :x)
#p node.children