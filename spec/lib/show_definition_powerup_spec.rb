require "spec_helper"

describe ShowDefinitionPowerup do
  let(:player) { Player.new }
  let(:answer) { Answer.new("Batman") }
  let(:game) { Game.new(player, answer) }

  it "adds definition of word to game" do

  end

  it "costs 25% of final score to use" do
    game.use_powerup!(:show_definition)
    game.new_guess "batman"

    expect(game.score).to eq 963
  end
end