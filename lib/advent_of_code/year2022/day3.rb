# frozen_string_literal: true

module AdventOfCode
  module Year2022
    class Day3 < AdventOfCode::BaseDay
      class Item
        attr_reader :letter

        def initialize(letter)
          @letter = letter
        end

        def priority
          case letter
          when "a".."z"
            letter.ord - "a".ord + 1
          when "A".."Z"
            letter.ord - "A".ord + 27
          end
        end
      end

      class Rucksack
        def initialize(items)
          @items = items.chars
        end

        def mixed_item
          Item.new(first_compartment.intersection(second_compartment).first)
        end

        private

        attr_reader :items

        def first_compartment
          items[0..(items.size / 2)]
        end

        def second_compartment
          items[(items.size / 2)..-1]
        end
      end

      class ElfGroup
        def initialize(lines)
          @lines = lines.map(&:chars)
        end

        def badge
          Item.new(lines.inject(&:intersection).first)
        end

        private

        attr_reader :lines
      end

      def part1
        rucksacks.map(&:mixed_item).sum(&:priority)
      end

      def part2
        elf_groups.map(&:badge).sum(&:priority)
      end

      private

      def rucksacks
        @_rucksacks ||= input_lines.map { Rucksack.new(_1) }
      end

      def elf_groups
        @_elf_groups ||= input_lines.each_slice(3).map do |lines|
          ElfGroup.new(lines)
        end
      end

      def input_lines
        @_input_lines ||= input.lines(chomp: true)
      end
    end
  end
end
