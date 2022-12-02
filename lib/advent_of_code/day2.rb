require_relative "../advent_of_code"

class AdventOfCode::Day2
  class Shape
    ROCK = new
    PAPER = new
    SCISSORS = new

    SHAPES = {
      ROCK => SCISSORS,
      PAPER => ROCK,
      SCISSORS => PAPER
    }

    def <=>(other)
      case other
      when self
        0
      when SHAPES[self]
        1
      else
        -1
      end
    end

    def losing_shape
      SHAPES[self]
    end

    def winning_shape
      SHAPES.invert[self]
    end

    private_class_method :new
  end

  class Part1Decrypter
    def initialize(string)
      @string = string
    end

    def round
      Round.new(opponent, me)
    end

    private

    attr_reader :string

    def opponent
      Shape::SHAPES.keys[string[0].ord - "A".ord]
    end

    def me
      Shape::SHAPES.keys[string[2].ord - "X".ord]
    end
  end

  class Part2Decrypter < Part1Decrypter
    private

    def me
      case string[2]
      when "X"
        opponent.losing_shape
      when "Y"
        opponent
      when "Z"
        opponent.winning_shape
      end
    end
  end

  class Round
    def initialize(opponent, me)
      @opponent = opponent
      @me = me
    end

    def score
      shape_score + outcome_score
    end

    private

    attr_reader :opponent, :me

    def shape_score
      case me
      when Shape::ROCK then 1
      when Shape::PAPER then 2
      when Shape::SCISSORS then 3
      end
    end

    def outcome_score
      ((me <=> opponent) + 1) * 3
    end
  end

  def part1
    score_with_decrypter(Part1Decrypter)
  end

  def part2
    score_with_decrypter(Part2Decrypter)
  end

  private

  def score_with_decrypter(decrypter_class)
    input.lines(chomp: true).map do |line|
      decrypter_class.new(line).round.score
    end.sum
  end

  def input
    @_input ||= File.read(File.join(__dir__, "..", "..", "data", "2022", "day2.txt"))
  end
end

day2 = AdventOfCode::Day2.new
puts day2.part1
puts day2.part2
