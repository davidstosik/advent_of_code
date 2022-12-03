# frozen_string_literal: true

require "test_helper"

module AdventOfCode
  module Year2022
    class Day3Test < Minitest::Test
      SAMPLE_INPUT = <<~INPUT
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      INPUT

      def setup
        @day3 = Day3.new
      end

      def test_item_priority
        assert_equal 1, Item.new("a").priority
        assert_equal 26, Item.new("z").priority
        assert_equal 27, Item.new("A").priority
        assert_equal 52, Item.new("Z").priority
      end

      def test_rucksack_mixed_item
        rucksack = Rucksack.new("abca")

        assert_equal "a", rucksack.mixed_item.letter
      end

      def test_elf_group_badge
        elf_group = ElfGroup.new(<<~LINES.lines(chomp: true))
          abac
          dedc
          fgfc
        LINES

        assert_equal "c", elf_group.badge.letter
      end

      def test_part1
        @day3.stub :input, SAMPLE_INPUT do
          assert_equal 157, @day3.part1
        end
      end

      def test_part2
        @day3.stub :input, SAMPLE_INPUT do
          assert_equal 70, @day3.part2
        end
      end
    end
  end
end
