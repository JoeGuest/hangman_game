module ShowDefinitionPowerup
  def cost
    0.25
  end

  def use!
    game.show_definition!
    game.take_from_bonus(cost)
  end
end