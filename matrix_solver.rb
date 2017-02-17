class MatrixSolver
  attr_reader :solution_count

  def initialize(_matrix)
    @matrix = _matrix
    @location = [0,0]
    @goal = [@matrix.length - 1, @matrix[0].length - 1]
    @dead_end = false
    @fork_locations = []
    @retry_fork = false
    @finished = false
    @solution_count = 0
  end

  def find_solutions
    solve until @finished
  end

  private
  def solve
    mark_cell
    find_path until @location == @goal || @dead_end

    @solution_count += 1 if @location == @goal
    @fork_locations.empty? ? @finished = true : revert_to_last_fork
  end

  def find_path
    if right?
      move_right
      mark_cell
    elsif down?
      move_down
      mark_cell
    else
      @dead_end = true
    end
  end

  def fork?
    if @retry_fork
      false
    else
      options = [right?, down?]
      options.count(true) > 1
    end
  end

  def mark_cell
    if fork?
      @matrix[y][x] = '$'
      remember_fork
    else
      @matrix[y][x] = 'x'
    end
  end

  def remember_fork
    f = Marshal.load(Marshal.dump(@location))
    @fork_locations << f
  end

  def revert_to_last_fork
    @retry_fork = true
    @location = @fork_locations.pop
    @dead_end = false
  end

  def right?
    if !@retry_fork
      cell = @matrix[y][x + 1]
      nopes = [0, nil, '$']

      !nopes.include?(cell)
    else
      false
    end
  end

  def down?
    if y != (@matrix.length - 1)
      cell = @matrix[y + 1][x]
      nopes = [0, :t, '$']

      !nopes.include?(cell)
    else
      false
    end
  end

  def move_right
    @location[1] += 1
  end

  def move_down
    @retry_fork = false
    @location[0] += 1
  end

  def x
    @location.last
  end

  def y
    @location.first
  end

end
