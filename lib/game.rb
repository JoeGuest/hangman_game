class Game
  attr_reader :player, :answer, :message

  def initialize(player, answer)
    @player = player    
    @answer = answer

    @current_score = 0
    @current_bonus = 1
    @results = []
  end

  def new_guess(guess)
    if completed?
      @message = "Game is finished"
    else
      this_guess = Guess.new(guess)
      handle_guess(this_guess)
      this_guess
    end
  end

  def use_powerup!(powerup_name)
    # todo: take percentage off total score at end of game
    # not current score

    powerup = Powerup.new(powerup_name, self)
    powerup.use!
  end

  def definition
    @answer.definition
  end

  def show_definition!
    @answer.show_definition!
  end

  def show_definition?
    @answer.show_definition?
  end

  def take_from_bonus(cost)
    @current_bonus -= cost
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
      completed_game_bonus + (@current_score * (1 + @current_bonus)).round
    else
      (@current_score * (1 + @current_bonus)).round
    end
  end

  def completed_game_bonus
    @player.lives * 25
  end

  def definition?
    false
  end

  private

  def handle_guess(guess)
    result = @answer.guess!(guess)

    action_for_guess(result, guess)
    set_message(result)

    if completed?
      finish_game
    end

    @results << result
  end

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
      # todo: calc streaks
      if @results.last == :correct
        @current_score += Abacus.new(guess, @answer, :streak).score
      else
        @current_score += Abacus.new(guess, @answer).score
      end        
    when :incorrect
      @player.lose_life!
    end
  end
end