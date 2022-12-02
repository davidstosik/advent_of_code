# frozen_string_literal: true

module AdventOfCode
  class BaseDay
    private

    def input
      Input.new(year, day).read
    end

    def year
      self.class.name[/(?<=::Year)\d+(?=::)/]
    end

    def day
      self.class.name[/(?<=Day)\d+$/]
    end
  end
end
