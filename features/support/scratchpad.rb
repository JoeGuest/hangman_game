class Player
  attr_accessor :current_game

  def make_guess(letter)
    guess = Guess.new(letter)
    current_game.check_guess(guess)
  end
end

class Game
  def initialize(player, answer)
    @player = player
    player.current_game = self

    @answer = answer
  end

  def check_guess(guess)
    if @answer.guess!(guess)
      @answer.current_answer
    else
      # error
    end
  end
end

class Guess
  attr_reader :letter

  def initialize(letter)
    @letter = letter
  end
end

class Answer
  attr_reader :word, :current_answer

  def initialize(word)
    # generate answer from dictionary
    @word = word || "Test"
    @current_answer = all_blanks
  end

  def guess!(guess)
    # return true if correct, else false
    word.split("").each_with_index do |letter, index|
      if guess.letter == letter
        @current_answer[index] = letter
      end
    end
  end

  private

  def all_blanks
    ["_"] * word.length
  end
end