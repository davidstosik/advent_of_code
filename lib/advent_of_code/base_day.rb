# frozen_string_literal: true

module AdventOfCode
  class BaseDay
    private

    def input_lines
      @_input_lines ||= input.lines(chomp: true)
    end

    def input
      @_input ||= Input.new(year, day).read
    end

    def year
      self.class.name[/(?<=::Year)\d+(?=::)/]
    end

    def day
      self.class.name[/(?<=Day)\d+$/]
    end
  end
end
