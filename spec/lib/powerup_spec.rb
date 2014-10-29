require "spec_helper"

describe Powerup do
  it "includes relevant powerup module" do
    powerup = Powerup.new(:show_definition,  double("Game"))

    expect(powerup.singleton_class.ancestors).to include ShowDefinitionPowerup
  end
end