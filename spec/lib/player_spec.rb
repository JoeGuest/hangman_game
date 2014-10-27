require "spec_helper"

describe Player do
  let(:player) { Player.new }

  it "initializes with 10 lives" do
    expect(player.lives).to eq 10
  end

  it "allows you to set lives"

  describe "#make_guess" do
    it "creates a Guess object and sends to Game"
  end

  describe "#lose_life!" do
    it "decrements lives"
  end

  describe "#dead?" do
    it "returns status of player"
  end
end