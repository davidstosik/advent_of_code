# frozen_string_literal: true

module AdventOfCode
  module CLI
    class Solve < Thor::Group
      namespace :solve
      desc "Solve given day's puzzle (defaults to today)"

      def self.register_in(parent)
        usage = banner.delete_prefix(basename + " ")
        parent.register(self, namespace, usage, desc)
      end

      TIME_OFFSET = "-0500"
      private_constant :TIME_OFFSET

      argument :day,
        type: :numeric,
        optional: true,
        default: Time.now.localtime(TIME_OFFSET).day,
        desc: "The day on the Advent Calendar (1-25)",
        banner: "DAY"

      def check_existence
        day_class
      rescue NameError
        say_error "No solution for #{date} yet.", :red
        exit
      end

      def command
        say "Solving puzzles for #{date}:"
        run_part(1)
        run_part(2)
      end

      private

      def run_part(part)
        solution = day_object.part(part).to_s
        solution = "\n#{solution}\n" if solution.include?("\n")
        say "Part #{part}: #{solution}"
      rescue NameError
        say "Part #{part} not implemented yet", :yellow
      end

      def day_object
        @_day_object ||= day_class.new
      end

      def day_class
        year_module.const_get("Day#{day}")
      end

      def year_module
        AdventOfCode.const_get("Year#{year}")
      end

      def date
        Date.new(year, 12, day)
      end

      def year
        2022
      end
    end
  end
end
