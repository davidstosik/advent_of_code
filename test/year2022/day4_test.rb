# frozen_string_literal: true

require "test_helper"

module AdventOfCode
  module Year2022
    class Day4Test < Minitest::Test
      SAMPLE_INPUT = <<~INPUT
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
      INPUT

      PART1_OUTPUT = 2
      PART2_OUTPUT = 4

      def setup
        @day = Day4.new
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
