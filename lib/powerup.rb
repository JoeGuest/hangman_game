class Powerup
  def initialize(powerup_name, game)
    @powerup_name = powerup_name
    @game = game

    include_powerup_module
  end

  def cost
    raise NotImplementedError, "you must implement 'cost'"
  end

  def use!
    raise NotImplementedError, "you must implement 'use!'"
  end

  private

  attr_reader :game
  
  def include_powerup_module
    self.extend(powerup_module)
  end

  def powerup_module
    Object.const_get(powerup_module_string)
  end

  def powerup_module_string
    @powerup_name.to_s.split("_").map(&:capitalize!).join + "Powerup"
  end
end