require "./features/support/scratchpad.rb"

Given(/^a new player$/) do
  @player = Player.new
end

When(/^player starts a new game$/) do
  @player.start_game
end

Then(/^new game is generated$/) do
  expect(@player.game).to be_a Game
end

Given(/^an incomplete word$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^player makes a correct guess$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^fill in blank\(s\) with letter$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^player makes an incorrect guess$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^player loses life$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^letter is moved to trash$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^draw hangman$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^player makes a duplicate guess$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^ignore guess$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^notify player that they are stupid$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^player guesses final letter of word$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^notify player that they are clever$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^player loses last life$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^notify player that they are dead$/) do
  pending # express the regexp above with the code you wish you had
end