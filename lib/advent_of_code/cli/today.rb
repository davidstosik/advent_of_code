# frozen_string_literal: true

module AdventOfCode
  module CLI
    class Today < Thor::Group
      TIME_OFFSET = "-0500"

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
    end
  end
end
