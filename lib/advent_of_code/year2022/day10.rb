# frozen_string_literal: true

module AdventOfCode
  module Year2022
    class Day10 < AdventOfCode::BaseDay
      class Screen
        WIDTH = 40
        HEIGHT = 6

        def initialize
          @pixels = Array.new(HEIGHT) { Array.new(WIDTH, false) }
          @row = 0
          @column = 0
        end

        def step(register_x)
          pixels[row][column] = (-1..1).cover?(column - register_x)
          self.column = (column + 1) % WIDTH
          self.row = (row + 1) % HEIGHT if column.zero?
        end

        def draw
          pixels.map do |row|
            row.map do |pixel|
              pixel ? "#" : "."
            end.join
          end.join("\n")
        end

        private

        attr_reader :pixels
        attr_accessor :row, :column
      end

      class Cpu
        attr_reader :signal_strength_sum, :screen

        def initialize
          @register_x = 1
          @cycles = 0
          @signal_strength_sum = 0
          @screen = Screen.new
        end

        def parse_instruction(instruction)
          case instruction.split(" ")
            in ["addx", value]
              addx(value.to_i)
            in ["noop"]
              noop
            else
              raise "unknown instruction: #{instruction}"
          end
        end

        private

        attr_accessor :register_x, :cycles
        attr_writer :signal_strength_sum

        def addx(v)
          step
          step
          self.register_x += v
        end

        def noop
          step
        end

        def step
          self.cycles +=1
          screen.step(register_x)
          if add_signal_strength?
            self.signal_strength_sum += signal_strength
          end
        end

        def add_signal_strength?
          (cycles - 20) % 40 == 0
        end

        def signal_strength
          cycles * register_x
        end
      end

      def part1
        cpu.signal_strength_sum
      end

      def part2
        cpu.screen.draw
      end

      private

      def cpu
        return @_cpu if defined?(@_cpu)

        @_cpu = Cpu.new
        run_instructions
        @_cpu
      end

      def run_instructions
        input_lines.each do |instruction|
          cpu.parse_instruction(instruction)
        end
      end
    end
  end
end
