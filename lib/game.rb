class Game
  attr_reader :player, :answer, :message

  def initialize(player, answer)
    @player = player
    player.current_game = self

    @answer = answer
  end

  def make_guess(guess)
    this_guess = Guess.new(guess)
    check_guess(this_guess)
    this_guess
  end

  def check_guess(guess)
    case @answer.guess!(guess)
    when :correct
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
    (@player.dead? || @answer.completed?) || false
  end

  def guesses
    @answer.guesses
  end

  def wrong_guesses
    @answer.wrong_guesses
  end
end