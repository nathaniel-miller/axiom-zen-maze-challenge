require 'pry'

class MatrixSolver
  attr_accessor :matrix, :location, :goal, :stuck, :memory
  attr_reader :solution_count

  def initialize(_matrix)
    @matrix = _matrix
    @location = [0,0]
    @goal = [matrix.length - 1, matrix[0].length - 1]
    @stuck = false
    @solution_count = 0
    @other_options = []
    @memory = {}
  end

  def solve
    # binding.pry
    # binding.pry if location == [0, 10]
    leave_mark

    until location == goal || stuck do
      find_path
    end

    if location == goal
      # binding.pry
      @solution_count += 1
    end

    unless memory.empty?
      revert_to_last_fork
      solve
    end
  end

  def find_path
    # binding.pry
    if right?
      move_right
      leave_mark
    elsif down?
      move_down
      leave_mark
    else
      @stuck = true
    end
  end

  def fork?
    # binding.pry
    options = [right?, down?]
    options.count(true) > 1
  end




  private
  def leave_mark
    # binding.pry
    if fork?
      matrix[y][x] = '$'
      remember_fork
    else
      matrix[y][x] = 'x'
    end
  end

  def remember_fork
    # binding.pry
    m = Marshal.load(Marshal.dump(matrix))
    l = Marshal.load(Marshal.dump(location))

    memory[memory.size] = {}
    memory[memory.size - 1][:matrix] = m
    memory[memory.size - 1][:location] = l
  end

  def revert_to_last_fork
    # binding.pry
    @matrix = memory[memory.size - 1][:matrix]
    @location = memory[memory.size - 1][:location]
    @stuck = false
    block_previous_route
    memory.delete(memory.size - 1)
  end

  def cannot_reach_goal?
    location[0] != goal[0] - 1 && location[1] != goal[1] - 1
  end

  def block_previous_route
    # binding.pry
    if right?
      matrix[y][x + 1] = :l
    elsif down?
      matrix[y + 1][x] = :t
    end
  end

  def right?
    cell = matrix[y][x + 1]
    nopes = [0, :l, nil, '$']

    !nopes.include?(cell)
  end

  def down?
    if y != (matrix.length - 1)
      cell = matrix[y + 1][x]
      nopes = [0, :t, '$']

      !nopes.include?(cell)
    else
      false
    end
  end

  def move_right
    location[1] += 1
  end

  def move_down
    location[0] += 1
  end

  def x
    location.last
  end

  def y
    location.first
  end

end
