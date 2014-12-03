class Minefield
  attr_reader :row_count, :column_count

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_count = mine_count
    @cleared_cells = []
    @mine_cells = mine_cells
  end

  def mine_cells
    mine_cells = []
    number_of_mines = (@row_count * @column_count) / 3
    until mine_cells.length == number_of_mines
      mine_cell = [rand(@row_count), rand(@column_count)]
        mine_cells << mine_cell unless mine_cell.include?(mine_cell)
    end
    mine_cells
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    @cleared_cells.include?([row, col])
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    @adjacent_cells = [[row - 1, col - 1], [row, col - 1], [row + 1, col - 1],
                      [row - 1, col], [row + 1, col],
                      [row - 1, col + 1], [row, col + 1], [row + 1, col + 1]]
    @adjacent_cells.each do |cell|
      @cleared_cells << cell if !@mine_cells.include?(cell) && !@cleared_cells.include?([row, col])
    end
    @cleared_cells << [row, col]
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    detonated_mines = []
    @cleared_cells.each do |cell|
      if @mine_cells.include?(cell)
        detonated_mines << cell
      end
    end
    !detonated_mines.empty?
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    @cleared_cells.length - @mine_cells.length == @row_count * @column_count - @mine_cells.length
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    adjacent_cells = [[row - 1, col - 1], [row, col - 1], [row + 1, col - 1],
                      [row - 1, col], [row + 1, col],
                      [row - 1, col + 1], [row, col + 1], [row + 1, col + 1]]
    total = 0
    adjacent_cells.each do |cell|
      total += 1 if @mine_cells.include?(cell)
    end
    total
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    @mine_cells.include?([row, col])
  end
end
