class MatrixSolver
  attr_reader :solution_count

  def initialize(_matrix)
    @matrix = _matrix
    @location = [@matrix.length - 1, @matrix[0].length - 1]
  end

  def find_solutions
    solve until @finished
  end

  private
  def solve
    mark_cell
    move
  end

  def mark_cell
    if blocked?
      return
    elsif end?
      @matrix[row][col] = 1
    elsif fork?
      @matrix[row][col] = @matrix[row + 1][col] + @matrix[row][col + 1]
    elsif right?
      @matrix[row][col] = @matrix[row][col + 1]
    elsif down?
      @matrix[row][col] = @matrix[row + 1][col]
    else
      @matrix[row][col] = 0
    end
  end

  def blocked?
    @matrix[row][col] == 0
  end

  def end?
    @location == [@matrix.length - 1, @matrix[0].length - 1]
  end

  def beginning?
    @location == [0,0]
  end

  def fork?
    options = [right?, down?]
    options.count(true) > 1
  end

  def right?
    target = @matrix[row][col + 1]
    target != 0 && target != nil
  end

  def down?
    @matrix[row + 1] == nil ? false : @matrix[row + 1][col] != 0
  end

  def move
    if col != 0
      @location[1] -= 1
    elsif row != 0
      @location[0] -= 1
      @location[1] = @matrix[row].length - 1
    else
      complete
    end
  end

  def complete
    @finished = true
    @solution_count = @matrix[row][col] % 1000000007
  end

  def row
    @location.first
  end

  def col
    @location.last
  end

end
