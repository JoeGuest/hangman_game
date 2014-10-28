require "spec_helper"

describe Abacus do
  # need to know guess was correct
  # how many points letter is worth
  # how many occurrences of letter in word (half per occurrence)

  let(:answer) { Answer.new(("a".."z").to_a.join) }

  %w(a e i o u n r s t l).each do |letter|
    it "returns 1 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 1
    end
  end


  %w(g d).each do |letter|
    it "returns 2 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 2
    end
  end


  %w(b c m p).each do |letter|
    it "returns 3 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 3
    end
  end


  %w(y f v w).each do |letter|
    it "returns 4 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 4
    end
  end


  %w(k).each do |letter|
    it "returns 5 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 5
    end
  end


  %w(j x).each do |letter|
    it "returns 8 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 8
    end
  end

  %w(q z).each do |letter|
    it "returns 10 for #{letter}" do
      guess = Guess.new(letter)
      expect(Abacus.new(guess, answer).base_score).to eq 10
    end
  end

  context "for correct letter guesses" do
    it "returns x 10 of total base score" do
      guess = Guess.new("a")
      expect(Abacus.new(guess, answer).score).to eq 10
    end

    context "for multiple occurrences of letter" do
      it "halves base score of each letter" do
        @answer = Answer.new("Avengerers")
        @guess = Guess.new("e")

        expect(Abacus.new(@guess, @answer).score).to eq 15
      end
    end
  end

  context "for correct word guesses" do
    before do 
      @answer = Answer.new("Avengers")
      @guess = Guess.new("Avengers")
    end

    it "returns total base score for each correct letter" do
      expect(Abacus.new(@guess, @answer).base_score).to eq 12
    end

    it "returns x 3 of total base score" do
      expect(Abacus.new(@guess, @answer).score).to eq 360
    end
  end

  context "for incorrect guesses" do
    before do
      @answer = Answer.new("Avengers")
      @guess = Guess.new("b")
    end

    it "returns no points" do
      expect(Abacus.new(@guess, @answer).score).to eq 0
    end
  end

  context "for streaks" do
    before do
      @answer = Answer.new("Avengers")
    end

    it "adds 50% bonus points" do
      @guess = Guess.new("a")

      expect(Abacus.new(@guess, @answer, :streak).score).to eq 15
    end

    it "doesn't add bonus points for streak that involves word" do
      @guess = Guess.new("Avengers")

      expect(Abacus.new(@guess, @answer, :streak).score).to eq 360
    end
  end
end