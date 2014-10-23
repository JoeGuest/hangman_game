require "sinatra"
require "sinatra/reloader"

require "./features/support/scratchpad.rb"

get "/" do
  erb :splash
end

get "/hangman" do

  unless settings.respond_to?(:game)
    player = Player.new
    answer = Answer.new("Avengers")
    game = Game.new(player, answer)
    Sinatra::Application.set :game, game
  end

  erb :game, locals: { game: settings.game }
end

post "/hangman" do
  guess = params[:guess]

  settings.game.player.make_guess(guess)

  erb :game, locals: { game: settings.game }
end