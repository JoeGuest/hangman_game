require "spec_helper"

describe Guess do
  it "downcases all letters" do
    expect(Guess.new("T").string).to eq "t"
  end

  describe "#to_s" do
    it "returns letter" do
      expect(Guess.new("t").to_s).to eq "t"
    end
  end

  describe "#==" do
    it "compares against letter" do
      expect(Guess.new("A")).to eq Guess.new("A")
    end
  end

  describe "#auto_generated?" do
    context "when word is auto generated" do
      it "returns true" do
        guess = Guess.new("A", :auto_generated)

        expect(guess.auto_generated?).to eq true
      end
    end
  end
end