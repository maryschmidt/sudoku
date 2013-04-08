class Sudoku

  def define
    @puzzle = ["53..7....", "6..195...", ".98....6.", "8...6...3", "4..8.3..1", "7...2...6", ".6....28.", "...419..5", "....8..79"]
    @puzzle.join
  end
end

class Solver

  ASCII = ".0123456789"
  BINARY = "\000\001\002\003\004\005\006\007\010\011"

  def construct_array puzzle
    puzzle.tr!(ASCII, BINARY)
    @array = puzzle.unpack('c*')
    @array.size
  end

  def solve puzzle
  end
end

sudoku = Sudoku.new
puzzle = sudoku.define

solver = Solver.new
puts solver.construct_array(puzzle)
