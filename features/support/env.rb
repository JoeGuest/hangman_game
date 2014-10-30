require "capybara/cucumber"
require "./features/support/game_helper"

require "./lib/hangman"

require "sinatra"
require "./app/hangman"
Sinatra::Application.set :root, "./app"

def reset_test_game
  player = Player.new
  answer = Answer.new("Avengers")
  game = Game.new(player, answer)
  Sinatra::Application.set :game, game
end

reset_test_game
Capybara.app = Sinatra::Application

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end