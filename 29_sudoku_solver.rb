#!/usr/bin/env ruby

require 'Set'

class SodukoSolver
  def initialize(config)
    @@config = config.split(//)
  end

  def is_same_row(i, j)
    (i / 9) == (j / 9)
  end

  def is_same_column(i, j)
    (i % 9) == (j % 9)
  end

  def is_same_3x3_box(i, j)
    ((i / 27) == (j / 27)) && ((i % 9) / 3 == (j % 9) / 3)
  end

  def is_in_relation(i, j)
    is_same_row(i, j) || is_same_column(i, j) || is_same_3x3_box(i, j)
  end

  def possibilities_for_index(index)
    possibilities = Set.new
    81.times do |new_index|
      if is_in_relation(index, new_index) && @@config[new_index].to_i != 0
        possibilities << @@config[new_index].to_i
      end
    end
    (1..9).to_a - possibilities.to_a
  end
 
  def solve index
    if @@config[index].to_i == 0
      possibilities_for_index(index).each do |option|
        @@config[index] = option.to_s
        index == 80 ? show : solve(index + 1)
      end
      @@config[index] = 0
    else
      index == 80 ? show : solve(index + 1)
    end
  end

  def show
    horizontal_separator = "+-----------------------+"
    vertical_separator = "|"

    puts horizontal_separator
    81.times.each do |num|
      if num % 3 == 0 
        print vertical_separator, " "
      end
      print "#{@@config[num]} "
      if num % 9 == 8
        puts vertical_separator
        puts horizontal_separator 
      end
    end
  end
end

def validate config
  unless config =~ /^[0-9]{81}$/
    puts "Error: Wrong input config."
    exit 1
  end
end

def main
  puts %q{Enter initial config rowwise ("x1x2x3...x81"):}
  puts %q{Example: 007005008.......010}
  config = gets.chomp
  validate(config)

  sudoku_solver = SodukoSolver.new(config)
  puts "Solving..."
  sudoku_solver.solve 0
end

main if __FILE__ == $0
