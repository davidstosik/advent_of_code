# frozen_string_literal: true

module AdventOfCode
  class BaseDay
    private

    def input
      Input.new(year, day).read
    end

    def year
      "2022" # FIXME next year?
    end

    def day
      self.class.name[/(?<=Day)\d+$/]
    end
  end
end
