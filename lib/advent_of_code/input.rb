# frozen_string_literal: true

module AdventOfCode
  class Input
    def initialize(year, day)
      @year = year
      @day = day
    end

    def read
      File.read(local_path)
    end

    private

    attr_reader :year, :day

    def local_path
      File.join(__dir__, "..", "..", "data", year, "day#{day}.txt")
    end
  end
end
