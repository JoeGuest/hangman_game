class Abacus
  def initialize(guess, answer)
    @guess = guess
    @answer = answer
  end

  def base_score
    letter_values[@guess.string.to_sym] * 10
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