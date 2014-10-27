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