# frozen_string_literal: true

require "net/http"

module AdventOfCode
  module Year2022
    class Day1 < BaseDay
      def part1
        input_lines.inject(max: 0, sum: 0) do |acc, line|
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
    end
  end
end
