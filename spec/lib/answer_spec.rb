require "spec_helper"

describe Answer do
  let(:answer) { Answer.new("Avengers") }

  it "generates random word" do
    word1 = Answer.new.word
    word2 = Answer.new.word

    expect(word1 == word2).to eq false
  end

  it "allows you to define word" do
    expect(Answer.new("Hello").word).to eq "Hello"
  end

  describe "#guess!" do
    context "when incorrect" do
      it "returns :incorrect" do
        expect(answer.guess!(Guess.new("t"))).to eq :incorrect
      end
    end

    context "when correct" do
      it "returns :correct" do
        expect(answer.guess!(Guess.new("A"))).to eq :correct
      end
    end

    context "when invalid" do
      it "returns :invalid" do
        expect(answer.guess!(Guess.new("1"))).to eq :invalid
      end
    end

    context "when too many letters" do
      it "returns :too_many_letters" do
        expect(answer.guess!(Guess.new("abc"))).to eq :too_many_letters
      end
    end

    context "when duplicate" do
      it "returns :duplicate" do
        answer.guess!(Guess.new("A"))

        expect(answer.guess!(Guess.new("A"))).to eq :duplicate
      end
    end
  end

  describe "#complete!" do
    it "completes incomplete word" do
      answer = Answer.new
      answer.complete!

      expect(answer.word == answer.current_answer.join).to eq true
    end
  end

  describe "#complete?" do
    it "returns true if word complete" do
      answer = Answer.new
      answer.complete!

      expect(answer.completed?).to eq true
    end

    it "returns false if word incomplete" do
      expect(Answer.new.completed?).to eq false
    end
  end
end