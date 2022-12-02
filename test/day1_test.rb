# frozen_string_literal: true

require "test_helper"

module AdventOfCode
  class Day1Test < Minitest::Test
    SAMPLE_INPUT = <<~INPUT
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
    INPUT

    def setup
      @day1 = Day1.new
    end

    def test_part1
      @day1.stub :input, SAMPLE_INPUT do
        assert_equal 24000, @day1.part1
      end
    end

    def test_part2
      @day1.stub :input, SAMPLE_INPUT do
        assert_equal 45000, @day1.part2
      end
    end
  end
end
