require "sinatra"

get "/" do
  erb :splash
end

get "/hangman" do
  erb :game, locals: { game: settings.game }
end

post "/hangman" do
  guess = params[:guess]

  settings.game.player.make_guess(guess)

  erb :game, locals: { game: settings.game }
end