require "./features/support/scratchpad.rb"

Given(/^a new player$/) do
  @player = Player.new
end

When(/^player starts a new game$/) do
  @answer = Answer.new("Help")
  @game = Game.new(@player, @answer)  
end

Then(/^new game is generated$/) do
  expect(@player.current_game).to be_a Game
end

Given(/^an incomplete word$/) do
  @player = Player.new
  @answer = Answer.new("Help")
  @game = Game.new(@player, @answer)
end

When(/^player makes a correct guess$/) do
  @player.make_guess "H"
end

Then(/^fill in blank\(s\) with letter$/) do
  expect(@answer.current_answer).to eq ["H", "_", "_", "_"]
end

When(/^player makes an incorrect guess$/) do
  @player.make_guess "s"
end

Then(/^player loses life$/) do
  expect(@player.lives).to eq 9
end

Then(/^letter is moved to trash$/) do
  expect(@game.wrong_guesses.map(&:letter)).to include "s"
end

Then(/^draw hangman$/) do
  next
end

When(/^player makes a duplicate guess$/) do
  @player.make_guess "H"
end

Then(/^ignore guess$/) do
  expect(@player.lives).to eq 9
end

Then(/^notify player that they are stupid$/) do
  expect(@game.message).to eq "sorry, you are stupid"
end

When(/^player guesses final letter of word$/) do
  @player.make_guess "e"
  @player.make_guess "l"
  @player.make_guess "p"
end

Then(/^notify player that they are clever$/) do
  expect(@game.message).to eq "you win!"
end

When(/^player loses last life$/) do
  @player = Player.new(1)
  @answer = Answer.new("Help")
  @game = Game.new(@player, @answer)

  @player.make_guess "s"
end

Then(/^notify player that they are dead$/) do
  expect(@game.message).to eq "game over :("
end