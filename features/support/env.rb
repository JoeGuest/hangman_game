require "capybara/cucumber"
require "./features/support/scratchpad.rb"
require "./spec/support/game_helper.rb"

require "sinatra"
require "./app/hangman.rb"
Sinatra::Application.set :root, "./app"

def reset_test_game
  player = Player.new
  answer = Answer.new("Avengers")
  game = Game.new(player, answer)
  Sinatra::Application.set :game, game
end

reset_test_game
Capybara.app = Sinatra::Application