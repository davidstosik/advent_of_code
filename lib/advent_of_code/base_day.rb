# frozen_string_literal: true

module AdventOfCode
  class BaseDay
    private

    def input
      @_input ||= File.read(input_path)
    end

    def year
      "2022" # FIXME next year?
    end

    def day
      self.class.name[/(?<=Day)\d+$/]
    end

    def input_path
      File.join(__dir__, "..", "..", "data", year, "day#{day}.txt")
    end
  end
end
