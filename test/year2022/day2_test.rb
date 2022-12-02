# frozen_string_literal: true

require "test_helper"

module AdventOfCode
  module Year2022
    class Day2Test < Minitest::Test
      SAMPLE_INPUT = <<~INPUT
        A Y
        B X
        C Z
      INPUT

      def setup
        @day2 = Day2.new
      end

      def test_part1
        @day2.stub :input, SAMPLE_INPUT do
          assert_equal 15, @day2.part1
        end
      end

      def test_part2
        @day2.stub :input, SAMPLE_INPUT do
          assert_equal 12, @day2.part2
        end
      end
    end
  end
end
