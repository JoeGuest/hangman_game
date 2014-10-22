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
      @player.lose_life!
      
      # send letter to trash
      # @trash << guess

      # draw hangman

    end
  end

  def wrong_guesses
    @answer.wrong_guesses
  end
end

class Guess
  attr_reader :letter

  def initialize(letter)
    @letter = letter
  end
end

class Answer
  attr_reader :word,
              :current_answer,
              :guesses,
              :wrong_guesses

  def initialize(word)
    # generate answer from dictionary
    @word = word || "Test"
    @current_answer = all_blanks
    @guesses = []
    @wrong_guesses = []
  end

  def guess!(guess)
    found = false
    @guesses << guess

    # return true if correct, else false
    word.split("").each_with_index do |letter, index|
      if guess.letter == letter
        @current_answer[index] = letter
        found = true
      end
    end

    if !found
      @wrong_guesses << guess
    end

    found
  end

  private

  def all_blanks
    ["_"] * word.length
  end
end