require "spec_helper"

describe Player do
  let(:player) { Player.new }

  it "initializes with 10 lives" do
    expect(player.lives).to eq 10
  end

  it "allows you to set lives" do
    player = Player.new(5)
    expect(player.lives).to eq 5
  end

  describe "#new_guess" do
    it "creates a Guess object and sends to Game" do

    end
  end

  describe "#lose_life!" do
    it "decrements lives" do 
      player.lose_life!
      expect(player.lives).to eq 9
    end
  end

  describe "#dead?" do
    it "returns true when player has no lives" do
      player = Player.new(0)
      expect(player.dead?).to eq true
    end

    it "returns false if player has lives" do
      expect(player.dead?).to eq false
    end
  end
end