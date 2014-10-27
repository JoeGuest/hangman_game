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