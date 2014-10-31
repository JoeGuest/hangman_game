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
        parts << "<span class='auto-generated'>#{guess.string.upcase}</span>"
      else
        parts << guess.string.upcase
      end
    end

    current_answer.join(" ")
  end

  def render_answer_for_api(answer)
    current_answer = answer.inject([]) do |parts, guess|
      if guess == "_"
        parts << "__"
      else
        parts << guess.string.upcase
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
    # @text = "started game with word #{answer.word}\n"
    @text = render_answer_for_api(settings.game.answer.current_answer)
  elsif result.guess
    settings.game.new_guess(result.guess)
    
    @text =  "<< #{settings.game.message} >>\n\n"
    
    if settings.game.completed?
      @text += "type ';start' to start a new game"
    end

    @text += render_answer_for_api(settings.game.answer.current_answer) + "\n"

    if settings.game.completed?
      @text += settings.game.answer.find_definition + "\n\n"
    end

    @text += "Trash: #{settings.game.wrong_guesses.map(&:string).join(', ')}\n\n"

    @text += "Lives: #{settings.game.player.lives}\n"
    @text += "Score: #{settings.game.score}\n"
  end

  content_type :json
  { text: @text }.to_json
end