class Abacus
  def initialize(guess, answer)
    @guess = guess
    @answer = answer
  end

  def base_score
    total = 0

    if correct_guess?
      if guess_is_letter?
        total += base_score_for_letter
      elsif guess_is_word?
        total += base_score_for_word
      end
    end

    total
  end

  def score
    if guess_is_letter?
      base_score * 10
    elsif guess_is_word?
      base_score * 3
    end
  end

  def base_score_for_letter
    # todo: reduce duplication
    letter_values[@guess.string.to_sym]
  end

  def base_score_for_word
    @guess.string.split("").inject(0) do |total, letter|
      total += letter_values[letter.to_sym]
    end
  end

  def correct_guess?
    @answer.correct_guess?(@guess)
  end

  def guess_is_letter?
    @guess.letter?
  end

  def guess_is_word?
    @guess.word?
  end

  private

  def letter_values
    {
      a: 1,
      e: 1,
      i: 1,
      o: 1,
      u: 1,
      n: 1,
      r: 1,
      s: 1,
      t: 1, 
      l: 1,
      g: 2,
      d: 2,
      b: 3,
      c: 3,
      m: 3,
      p: 3,
      y: 4,
      f: 4,
      v: 4,
      w: 4,
      h: 4,
      k: 5,
      j: 8,
      x: 8,
      q: 10,
      z: 10
    }
  end
end