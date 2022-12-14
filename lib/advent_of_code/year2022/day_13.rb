# frozen_string_literal: true

require "json"

module AdventOfCode
  module Year2022
    class Packet
      def initialize(value)
        @value = value
      end

      def self.parse(input)
        new(JSON.parse(input))
      end

      def <=>(other)
        if int? && other.int?
          value <=> other.value
        elsif int?
          Packet.new([value]) <=> other
        elsif other.int?
          - (other <=> self)
        elsif size < other.size
          - (other <=> self)
        else
          value.zip(other.value).each do |a, b|
            return 1 if b.nil?

            comparison = Packet.new(a) <=> Packet.new(b)

            return comparison unless comparison == 0
          end
          if size == other.size
            0
          else
            -1
          end
        end
      end

      protected

      attr_reader :value

      def size
        if int?
          1
        else
          value.size
        end
      end

      def int?
        value.is_a?(Integer)
      end
    end

    class Day13 < AdventOfCode::BaseDay
      def part1
        pairs.each_with_index.inject(0) do |sum, ((a, b), index)|
          if (a <=> b) <= 0
            sum + index + 1
          else
            sum
          end
        end
      end

      private

      def pairs
        @pairs ||= input_lines.each_slice(3).map do |lines|
          lines[0..1].map { Packet.parse(_1) }
        end
      end
    end
  end
end
