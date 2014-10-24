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
    when :invalid
      @message = "Feeling special? You can only use a-z"
    when :too_many_letters
      @message = "Don't be greedy! One letter..."
    end

    check_complete_game
  end

  def check_complete_game
    if @player.dead?
      @answer.complete!
    elsif @answer.completed?
      @message = "You win!"
    end
  end

  def completed?
    @player.dead? || @answer.completed?
  end

  def wrong_guesses
    @answer.wrong_guesses
  end
end

class Guess
  attr_reader :letter

  def initialize(letter, type = nil)
    @letter = letter
    @type = type
  end

  def to_s
    letter
  end

  def ==(other)
    to_s == other.to_s
  end

  def auto_generated?
    @type == :auto_generated
  end
end

class Answer
  attr_reader :word,
              :current_answer,
              :guesses,
              :wrong_guesses

  def initialize(word = nil)
    # generate answer from dictionary
    @word = word || generate_new_word
    @current_answer = all_blanks
    @guesses = []
    @wrong_guesses = []
  end

  def generate_new_word
    File.readlines("./words/words.txt").sample.strip
  end

  def guess!(guess)
    result = :incorrect
    word_length = guess.letter.length

    if @guesses.include? guess
      result = :duplicate
    elsif guess.letter.match /[^a-z]/i
      result = :invalid
    elsif word_length > 1 && word_length != @word.length
      result = :too_many_letters
    else
      @guesses << guess

      if word_length == @word.length
        if guess.letter == @word
          letters.each_with_index do |letter, index|
            @current_answer[index] = Guess.new(letter)
          end
        else
          result = :incorrect
        end
      else
        # return true if correct, else false
        letters.each_with_index do |letter, index|
          if guess.letter == letter
            @current_answer[index] = guess
            result = :correct
          end
        end
      end

      if result == :incorrect
        @wrong_guesses << guess
      end
    end

    result
  end

  def complete!
    letters.each_with_index do |letter, index|
      if @current_answer[index] == '_'
        @current_answer[index] = Guess.new(letter, :auto_generated)
      end
    end
  end

  def completed?
    word == current_answer.join
  end

  private

  def all_blanks
    ["_"] * word.length
  end

  def letters_guessed_by_player
    @guesses.map(&:letter)
  end

  def letters
    @word.split("")
  end 
end