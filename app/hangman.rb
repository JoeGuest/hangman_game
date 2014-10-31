require "sinatra"
require "sinatra/reloader"
require "json"

require "./lib/hangman"

set :server, 'thin'
set :erb, escape_html: false

helpers do
  def render_answer(answer)
    current_answer = answer.inject([]) do |parts, guess|
      if guess == "_"
        parts << "<span class ='test'>#{guess}</span>"
      elsif guess.auto_generated?
        parts << "<span class='auto-generated'>#{guess.string.capitalize}</span>"
      else
        parts << guess.string.capitalize
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
  settings.game.new_guess(guess)

  erb :game, locals: { game: settings.game }
end

get "/hangman/powerup" do
  settings.game.use_powerup!(params[:powerup])
  redirect "/hangman"
end

post "/api/" do
  result = SlackResult.new(indifferent_params(params), :skip_authentication)
  @text = ""

  if result.user_name == "slackbot" 
    status 200
    body ''
    return
  end

  if result.command == "start"
    player = Player.new
    answer = Answer.new
    game = Game.new(player, answer)
    Sinatra::Application.set :game, game 
    @text = "started game with word #{answer.word}"
  elsif result.guess
    settings.game.new_guess(result.guess)
    @text = "made guess #{result.guess}, current answer: #{settings.game.answer.current_answer.join('')}"
  end

  content_type :json
  { text: @text }.to_json
end