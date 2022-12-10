# frozen_string_literal: true

module AdventOfCode
  module CLI
    class Today < Thor::Group
      namespace :today
      desc "Solve today's puzzles"

      def self.register_in(parent)
        usage = banner.delete_prefix(basename + " ")
        parent.register(self, namespace, usage, desc)
      end

      def command
        say "Solving puzzles for #{time.strftime("%Y-%m-%d")}"
        run_part(1)
        run_part(2)
      end

      private

      def run_part(part)
        return unless day_object.respond_to?("part#{part}")

        say "Part #{part}: " + day_object.public_send("part#{part}").to_s
      end

      def day_object
        @_day_object ||= day_class.new
      end

      def day_class
        year_module.const_get("Day#{time.day}")
      end

      def year_module
        AdventOfCode.const_get("Year#{time.year}")
      end

      def time
        @_time ||= Time.now.localtime(TIME_OFFSET)
      end

      TIME_OFFSET = "-0500"
      private_constant :TIME_OFFSET
    end
  end
end
