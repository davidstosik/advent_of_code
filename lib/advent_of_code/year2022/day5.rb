# frozen_string_literal: true

module AdventOfCode
  module Year2022
    class Day5 < AdventOfCode::BaseDay
      class CrateMover9000
        attr_reader :stacks, :moves

        def initialize(stacks, moves)
          @stacks = stacks.dup
          @moves = moves
        end

        def output
          run
          stacks.map(&:last).join
        end

        def run
          moves.each do |move|
            move[0].times do
              box = stacks[move[1] - 1].pop
              stacks[move[2] - 1].push(box)
            end
          end
        end
      end

      class CrateMover9001 < CrateMover9000
        def run
          moves.each do |move|
            boxes = stacks[move[1] - 1].pop(move[0])
            stacks[move[2] - 1].push(*boxes)
          end
        end
      end

      def part1
        CrateMover9000.new(starting_stacks, moves).output
      end

      def part2
        CrateMover9001.new(starting_stacks, moves).output
      end

      def starting_stacks
        stacks = Array.new(stack_count) { [] }

        stacks_input.each do |line|
          stack_count.times do |stack_index|
            box = line[1 + stack_index * 4]
            stacks[stack_index].prepend(box) unless box == " "
          end
        end

        return stacks
      end

      def moves
        @_moves ||= moves_input.map do |line|
          line.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
        end
      end

      private

      def stacks_input
        split_input[0]
      end

      def stack_count
        split_input[1].squeeze.split(" ").last.to_i
      end

      def moves_input
        split_input[2]
      end

      def split_input
        @_split_input ||= begin
          empty_line = input_lines.index("")
          [
            input_lines[0..empty_line - 2],
            input_lines[empty_line - 1],
            input_lines[empty_line + 1..-1]
          ]
        end
      end
    end
  end
end
