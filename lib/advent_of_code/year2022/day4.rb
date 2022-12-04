# frozen_string_literal: true

module AdventOfCode
  module Year2022
    class Day4 < AdventOfCode::BaseDay
      def part1
        pairs.count do |range1, range2|
          range1.cover?(range2) || range2.cover?(range1)
        end
      end

      def part2
        pairs.count do |range1, range2|
          range1, range2 = range2, range1 if range1.min > range2.min
          range2.min <= range1.max
        end
      end

      private

      def pairs
        @pairs ||= input_lines.map do |line|
          line.split(",").map do |range|
            low, high = range.split("-")
            low.to_i..high.to_i
          end
        end
      end
    end
  end
end
