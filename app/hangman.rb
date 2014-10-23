require "sinatra"

get "/" do
  erb :splash
end

get "/hangman" do
  erb :game, locals: { answer: settings.game.answer.current_answer_as_string }
end

post "/hangman" do
  guess = params[:guess]

  settings.game.player.make_guess(guess)

  erb :game, locals: { answer: settings.game.answer.current_answer_as_string }
end