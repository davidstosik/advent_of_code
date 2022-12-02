# frozen_string_literal: true

require "net/http"

module AdventOfCode
  class Day1
    def part1
      input.lines(chomp: true).inject(max: 0, sum: 0) do |acc, line|
        if line.empty?
          acc[:max] = acc[:sum] if acc[:sum] > acc[:max]
          acc[:sum] = 0
        else
          acc[:sum] += line.to_i
        end
        acc
      end[:max]
    end

    def part2
      input.split("\n\n").map do |group|
        group.lines(chomp: true).map(&:to_i).sum
      end.sort.last(3).sum
    end

    def input
      @_input ||= File.read(File.join(__dir__, "..", "..", "data", "2022", "day1.txt"))
    end
  end
end
