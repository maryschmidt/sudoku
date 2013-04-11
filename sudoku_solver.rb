class Sudoku
  def define
    puzzle = ["53467891.", "67.1953.8", "198342.67", "85976...3", "4..8.3..1", "71392...6", ".6....28.", "287419635", "345286179"]
    array = puzzle.join.split(//).map(&:to_i)
  end
end

class Solver
  DIGITS = [1,2,3,4,5,6,7,8,9]

  def solve puzzle
    @cells = []

    while choices? puzzle
      make_a_choice puzzle

      while puzzle.index(nil)
        @cells.rotate!(-1)
        cell = @cells.last
        puzzle[cell] = 0

        make_columns puzzle
        make_rows puzzle

        allowed_digits = DIGITS - @columns[cell % 9] - @rows[cell / 9] - @blocks[cell/27] && @blocks[cell % 9]

        puzzle[cell] = allowed_digits.shift
      end
    end

    puts @blocks.inspect
    puts puzzle.inspect
  end

  private

  def choices? puzzle
    puzzle.index(0)
  end

  def make_a_choice puzzle
    cell = puzzle.index(0)

    make_columns puzzle
    make_rows puzzle
    make_blocks puzzle

    allowed_digits = DIGITS - @columns[cell % 9] - @rows[cell / 9]
    puzzle[cell] = allowed_digits[0]
    @cells << cell
  end

  def make_columns puzzle
    @columns = (0..8).map do |j|
      9.times.inject([]) { |col, i| col << puzzle[9*i+j] }
    end
  end

  def make_rows puzzle
    @rows = puzzle.each_slice(9).to_a
  end

  def make_blocks puzzle
    @blocks = (0..8).map do |j|
      3.times.inject([]) { |box, i| box << puzzle[9*i+j] }
    end.each_slice(3).map(&:flatten)
  end
end

sudoku = Sudoku.new
puzzle = sudoku.define

solver = Solver.new
solver.solve(puzzle)
