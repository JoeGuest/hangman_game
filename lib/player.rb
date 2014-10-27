class Player
  attr_reader :lives
  attr_accessor :current_game

  def initialize(lives = 10)
    @lives = lives
  end

  def make_guess(letter)
    guess = Guess.new(letter)
    current_game.check_guess(guess)
  end

  def lose_life!
    @lives -= 1
  end

  def dead?
    @lives == 0
  end
end