# frozen_string_literal: true

module AdventOfCode
  module CLI
    class Generate < Thor::Group
      include Thor::Actions

      namespace :generate
      desc "Generate scaffolds to solve a day's puzzles"

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

      def self.source_root
        File.dirname(__FILE__)
      end

      def command
        template("templates/day.rb.tt", "lib/advent_of_code/year#{year}/day_#{day}.rb")
        template("templates/day_test.rb.tt", "test/year#{year}/day#{day}_test.rb")
      end

      private

      def date
        Date.new(year, 12, day)
      end

      def year
        2022
      end
    end
  end
end
