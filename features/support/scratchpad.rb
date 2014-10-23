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

class Game
  attr_reader :player, :answer, :message

  def initialize(player, answer)
    @player = player
    player.current_game = self

    @answer = answer
  end

  def check_guess(guess)
    case @answer.guess!(guess)
    when :correct
      @answer.current_answer
      @message = "correct!"
    when :incorrect
      @player.lose_life!
      # send letter to trash
      # @trash << guess
      # draw hangman

      if @player.dead?
        @message = "Game over :("
      else
        @message = "wrong!"
      end

    when :duplicate
      @message = "Have we met before?"
    end

    check_complete_answer
  end

  def check_complete_answer
    if @answer.completed?
      @message = "You win!"
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

  def ==(other)
    letter == other.letter
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
    result = :incorrect
    if @guesses.include? guess
      result = :duplicate
    else
      @guesses << guess

      # return true if correct, else false
      word.split("").each_with_index do |letter, index|
        if guess.letter == letter
          @current_answer[index] = letter
          result = :correct
        end
      end

      if result == :incorrect
        @wrong_guesses << guess
      end
    end

    result
  end

  def completed?
    word == current_answer.join
  end

  private

  def all_blanks
    ["_"] * word.length
  end
end