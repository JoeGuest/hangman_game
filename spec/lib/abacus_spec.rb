require "spec_helper"

describe Abacus do
  # need to know guess was correct
  # how many points letter is worth
  # how many occurrences of letter in word (half per occurrence)

  let(:answer) { Answer.new("Avengers") }

  %w(a e i o u n r s t l).each do |letter|
    it "returns 10 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 10
    end
  end

  context "for correct guesses"
  context "for streaks"

end