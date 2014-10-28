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


  %w(g d).each do |letter|
    it "returns 20 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 20
    end
  end


  %w(b c m p).each do |letter|
    it "returns 30 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 30
    end
  end


  %w(y f v w).each do |letter|
    it "returns 40 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 40
    end
  end


  %w(k).each do |letter|
    it "returns 50 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 50
    end
  end


  %w(j x).each do |letter|
    it "returns 80 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 80
    end
  end


  %w(q z).each do |letter|
    it "returns 100 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 100
    end
  end

  context "for correct guesses"
  context "for streaks"

end