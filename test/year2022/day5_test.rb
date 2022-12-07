# frozen_string_literal: true

require "test_helper"

module AdventOfCode
  module Year2022
    class Day5Test < Minitest::Test
      SAMPLE_INPUT = <<~INPUT
            [D]    
        [N] [C]    
        [Z] [M] [P]
         1   2   3 

        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
      INPUT

      PART1_OUTPUT = "CMZ"
      PART2_OUTPUT = "MCD"

      def setup
        @day = Day5.new
      end

      def test_starting_stacks
        @day.stub :input, SAMPLE_INPUT do
          assert_equal [%w(Z N), %w(M C D), %w(P)], @day.starting_stacks
        end
      end

      def test_cratemover9000_run
        @day.stub :input, SAMPLE_INPUT do
          crate_mover = Day5::CrateMover9000.new(@day.starting_stacks, @day.moves)

          crate_mover.run

          assert_equal [%w(C), %w(M), %w(P D N Z)], crate_mover.stacks
        end
      end

      def test_cratemover9001_run
        @day.stub :input, SAMPLE_INPUT do
          crate_mover = Day5::CrateMover9001.new(@day.starting_stacks, @day.moves)

          crate_mover.run

          assert_equal [%w(M), %w(C), %w(P Z N D)], crate_mover.stacks
        end
      end

      def test_part1
        @day.stub :input, SAMPLE_INPUT do
          assert_equal PART1_OUTPUT, @day.part1
        end
      end

      def test_part2
        @day.stub :input, SAMPLE_INPUT do
          assert_equal PART2_OUTPUT, @day.part2
        end
      end
    end
  end
end
