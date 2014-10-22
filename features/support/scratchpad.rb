class Player
  attr_reader :game

  def start_game
    @game = Game.new(self)
  end
end

class Game
  def initialize(player)
  end
end

class Guess
end

class Answer
end