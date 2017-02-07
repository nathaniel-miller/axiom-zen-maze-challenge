#! /usr/bin/env ruby


# Complete the function below, the input variable "matrix" is
# a two-dimensional array of integers, zero or one, organized by
# row (i.e. find elements by subscripting matrix[row][col])
#
# The return value should be an integer specifying the number
# of valid paths through the matrix.
def numberOfPaths(matrix) 
  result = 0
  
  return result
end


# All text below this line is to read and write the test data only

gets

_matrix = $stdin.collect {|x| x.split.collect {|y| Integer(y)}}

res = numberOfPaths(_matrix);
$stdout.write res;
$stdout.write "\n"

