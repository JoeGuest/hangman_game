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
  reset_test_game
  visit "/hangman"
end

When(/^player makes a correct guess$/) do
  make_guess "A"
end

Then(/^fill in blank\(s\) with letter$/) do
  expect_answer_to_be "A _ _ _ _ _ _ _"
end

When(/^player makes an incorrect guess$/) do
  make_guess "p"
end

Then(/^player loses life$/) do
  expect_lives_to_be 9
end

Then(/^letter is moved to trash$/) do
  expect_trash_to_contain "p"
end

Then(/^draw hangman$/) do
  next
end

When(/^player makes a duplicate guess$/) do
  reset_test_game
  make_guess "A"
  make_guess "A"
end

Then(/^ignore guess$/) do
  expect_lives_to_be 10
end

Then(/^notify player that they are stupid$/) do
  expect_message_to_be "Have we met before?"
end

When(/^player guesses an invalid character$/) do
  reset_test_game
  make_guess "1"
end

Then(/^notify player that they are rebellious$/) do
  expect_message_to_be "Feeling special? You can only use a-z"
end

When(/^player guesses final letter of word$/) do
  %w(A v e n g e r s).each do |letter|
    make_guess letter
  end
end

Then(/^notify player that they are clever$/) do
  expect_message_to_be "You win!"
end

When(/^player loses last life$/) do  
  reset_test_game

  visit "/hangman"

  letters = ("a".."z").to_a - %w(A v e n g e r s)

  letters.first(10).each do |letter|
    make_guess letter
  end
end

Then(/^notify player that they are dead$/) do
  expect_message_to_be "Game over :("
end

Then(/^show answer$/) do
  expect_answer_to_be "A v e n g e r s"
end

Given(/^a finished game$/) do
  reset_test_game

  visit "/hangman"

  letters = ("a".."z").to_a - %w(A v e n g e r s)

  letters.first(10).each do |letter|
    make_guess letter
  end  
end

Then(/^prevent further guesses$/) do
  expect(page).to_not have_css "#guess"
end

World(GameHelper)