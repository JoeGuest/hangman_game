require "sinatra"
require "sinatra/reloader"

require "./lib/hangman"

set :erb, escape_html: false

helpers do
  def render_answer(answer)
    current_answer = answer.inject([]) do |parts, guess|
      if guess == "_"
        parts << "<span class ='test'>#{guess}</span>"
      elsif guess.auto_generated?
        parts << "<span class='auto-generated'>#{guess.string}</span>"
      else
        parts << guess.string
      end
    end

    current_answer.join(" ")
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

  if params[:powerup]
    settings.game.use_powerup(params[:powerup])
  end

  settings.game.new_guess(guess)

  erb :game, locals: { game: settings.game }
end