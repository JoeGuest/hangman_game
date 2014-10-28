class Guess
  attr_reader :string

  def initialize(string, type = nil)
    @string = string.downcase
    @type = type
  end

  def to_s
    string
  end

  def letter?
    string.length == 1
  end

  def word?
    string.length > 1
  end

  def ==(other)
    to_s == other.to_s
  end

  def auto_generated?
    @type == :auto_generated
  end
end