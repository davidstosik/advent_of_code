# frozen_string_literal: true

require "test_helper"

module AdventOfCode
  module Year2022
    class Day13Test < Minitest::Test
      SAMPLE_INPUT = <<~INPUT
        [1,1,3,1,1]
        [1,1,5,1,1]

        [[1],[2,3,4]]
        [[1],4]

        [9]
        [[8,7,6]]

        [[4,4],4,4]
        [[4,4],4,4,4]

        [7,7,7,7]
        [7,7,7]

        []
        [3]

        [[[]]]
        [[]]

        [1,[2,[3,[4,[5,6,7]]]],8,9]
        [1,[2,[3,[4,[5,6,0]]]],8,9]
      INPUT

      SAMPLE_COMPARE_RESULTS = [-1, -1, 1, -1, 1, -1, 1, 1]

      PART1_OUTPUT = 13
      PART2_OUTPUT = 0

      def setup
        @day = Day13.new
      end

      def test_packet_compare
        assert_equal -1, Packet.new(1) <=> Packet.new(2)
        assert_equal 0, Packet.new(1) <=> Packet.new(1)
        assert_equal 0, Packet.new(1) <=> Packet.new([1])
        assert_equal -1, Packet.new(1) <=> Packet.new([2])
        assert_equal 0, Packet.new([1]) <=> Packet.new(1)
        assert_equal -1, Packet.new([[]]) <=> Packet.new([[[]]])
      end

      def test_packet_compare_with_sample
        SAMPLE_INPUT.lines(chomp: true).each_slice(3).with_index do |lines, index|
          a, b = lines[0], lines[1]
          assert_equal SAMPLE_COMPARE_RESULTS[index], Packet.parse(a) <=> Packet.parse(b), "expected #{a} <=> #{b} to be #{SAMPLE_COMPARE_RESULTS[index]}"
        end
      end

      def test_part1
        @day.stub :input, SAMPLE_INPUT do
          assert_equal PART1_OUTPUT, @day.part1
        end
      end

      def test_part2
        skip
        @day.stub :input, SAMPLE_INPUT do
          assert_equal PART2_OUTPUT, @day.part2
        end
      end
    end
  end
end
