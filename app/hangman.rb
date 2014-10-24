require "sinatra"
require "sinatra/reloader"

require "./features/support/scratchpad.rb"

helpers do
  def render_answer(answer)
    current_answer = answer.inject("") do |str, guess|
      if guess == "_"
        str << guess
      elsif guess.auto_generated?
        str << "<span class='auto-generated'>#{guess.letter}</span>"
      else
        str << guess.letter
      end
    end

    current_answer.split("").join(" ")
  end
end

get "/" do
  erb :splash
end

get "/hangman" do
  unless settings.respond_to?(:game)
    player = Player.new
    answer = Answer.new
    game = Game.new(player, answer)
    Sinatra::Application.set :game, game
  end

  erb :game, locals: { game: settings.game }
end

get "/hangman/new" do
  player = Player.new
  answer = Answer.new
  game = Game.new(player, answer)
  Sinatra::Application.set :game, game 
  
  redirect "/hangman" 
end

post "/hangman" do
  guess = params[:guess]

  settings.game.player.make_guess(guess)

  erb :game, locals: { game: settings.game }
end