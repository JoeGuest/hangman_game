class Game
  attr_reader :player, :answer, :message, :current_score

  def initialize(player, answer)
    @player = player    
    @answer = answer

    @current_score = 0
  end

  def new_guess(guess)
    this_guess = Guess.new(guess)
    handle_guess(this_guess)
    this_guess
  end

  def handle_guess(guess)
    result = @answer.guess!(guess)

    action_for_guess(result, guess)
    set_message(result)

    if completed?
      finish_game
    end
  end

  def completed?
    @player.dead? || @answer.completed?
  end

  def guesses
    @answer.guesses
  end

  def wrong_guesses
    @answer.wrong_guesses
  end

  def score
    if completed?
      @current_score + completed_game_bonus
    else
      @current_score
    end
  end

  def completed_game_bonus
    @player.lives * 25
  end

  private

  def finish_game
    if @answer.completed?
      set_message(:complete)
    else
      @answer.autocomplete!
    end
  end

  def set_message(type)
    case type
    when :complete
      @message = "You win!"
    when :correct
      @message = "correct!"
    when :incorrect
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
  end

  def action_for_guess(type, guess)
    case type
    when :correct
      @current_score += Abacus.new(guess, @answer).score
    when :incorrect
      @player.lose_life!
    end
  end
end