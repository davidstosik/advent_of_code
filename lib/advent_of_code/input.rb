# frozen_string_literal: true

module AdventOfCode
  class Input
    def initialize(year, day)
      @year = year
      @day = day
    end

    def read
      if File.exist?(local_path)
        File.read(local_path)
      else
        raise "Input data was not found locally"
      end
    end

    private

    attr_reader :year, :day

    def local_path
      File.join(__dir__, "..", "..", "data", year, "day#{day}.txt")
    end
  end
end
