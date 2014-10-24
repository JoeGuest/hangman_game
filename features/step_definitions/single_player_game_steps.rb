Given(/^a new player$/) do
  @player = Player.new
end

When(/^player starts a new game$/) do
  visit "/hangman"  
end

Then(/^new game is generated$/) do
  within("#answer") do
    expect(page).to_not match /[a-z]/i
  end
end

Given(/^an existing game$/) do
  visit "/hangman"
  make_guess "A"
end

When(/^player requests new game$/) do
  click_link "new game"
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
  expect(@game.message).to eq "Have we met before?"
end

When(/^player guesses final letter of word$/) do
  @player.make_guess "e"
  @player.make_guess "l"
  @player.make_guess "p"
end

Then(/^notify player that they are clever$/) do
  expect(@game.message).to eq "You win!"
end

When(/^player loses last life$/) do
  @player = Player.new(1)
  @answer = Answer.new("Help")
  @game = Game.new(@player, @answer)

  @player.make_guess "s"
end

Then(/^notify player that they are dead$/) do
  expect(@game.message).to eq "Game over :("
end

World(GameHelper)