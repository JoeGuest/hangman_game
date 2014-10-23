require "spec_helper"

# answer is Avengers

feature "single player game" do

  before do
    visit "/hangman"
  end

  scenario "player starts game" do
    visit "/"

    click_link "Start Game"

    expect(page).to have_css "#answer"
  end

  scenario "player makes multiple correct guesses" do
    make_guess "A"  

    expect_answer_to_be "A _ _ _ _ _ _ _"

    make_guess "v"
    
    expect_answer_to_be "A v _ _ _ _ _ _"
  end

  scenario "player makes an incorrect guess" do
    make_guess "t"

    expect_answer_to_be "_ _ _ _ _ _ _ _"
    expect_trash_to_contain "t"
    expect_lives_to_be 9
  end

  scenario "player makes a duplicate guess" do
    make_guess "A"
    make_guess "A"

    expect(page).to have_content "Have we met before?"
  end

  scenario "player loses all lives" do
    letters = ("a".."z").to_a - %w(A v e n g e r s)

    letters.first(10).each do |letter|
      make_guess letter
    end

    expect(page).to have_content "Game over :("
  end

  scenario "player guesses all letters" do
    "Avengers".split("").each do |letter|
      make_guess letter
    end

    expect(page).to have_content "You win!"
  end

end