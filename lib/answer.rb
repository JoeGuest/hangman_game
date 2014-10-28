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

    @word.downcase!
  end

  def guess!(guess)
    result = result_for_guess(guess)
    action_for_guess(guess, result)

    result
  end

  def autocomplete!
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

  def generate_new_word
    File.readlines("./words/words.txt").sample.strip
  end

  def all_blanks
    ["_"] * word.length
  end

  def letters_guessed_by_player
    @guesses.map(&:letter)
  end

  def letters
    @word.split("")
  end

  def duplicate_guess?(guess)
    @guesses.include?(guess) || @wrong_guesses.include?(guess)
  end

  def invalid_guess?(guess)
    guess.string.match /[^a-z]/i
  end

  def too_many_letters?(guess)
    word_length = guess.string.length
    word_length > 1 && word_length != @word.length
  end

  def correct_guess?(guess)
    if guess.string.length == 1
      letters.include? guess.string
    else
      @word == guess.string
    end
  end

  def result_for_guess(guess)
    if duplicate_guess?(guess)
      :duplicate
    elsif invalid_guess?(guess)
      :invalid
    elsif too_many_letters?(guess)
      :too_many_letters
    elsif correct_guess?(guess)
      :correct
    elsif !correct_guess?(guess)
      :incorrect
    end
  end

  def action_for_guess(guess, result)
    case result
    when :correct
      @guesses << guess
      update_current_answer(guess)
    when :incorrect
      @wrong_guesses << guess
    end
  end

  def update_current_answer(guess)
    if guess.string == @word
      complete_word_for_player
    else
      update_current_answer_with_letter(guess)
    end
  end

  def complete_word_for_player
    letters.each_with_index do |letter, index|
      @current_answer[index] = Guess.new(letter)
    end
  end

  def update_current_answer_with_letter(guess)
    letters.each_with_index do |letter, index|
      if guess.string == letter
        @current_answer[index] = guess
      end
    end
  end
end