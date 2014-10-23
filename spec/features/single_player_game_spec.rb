require "spec_helper"

# answer is Avengers

feature "single player game" do
  scenario "player starts game" do
    visit "/"

    click_link "Start Game"

    expect(page).to have_css "#answer"
  end

  scenario "player makes multiple correct guesses" do
    visit "/hangman"

    make_guess "A"  

    expect_answer_to_be "A _ _ _ _ _ _ _"

    make_guess "v"
    
    expect_answer_to_be "A v _ _ _ _ _ _"
  end

  scenario "player makes an incorrect guess" do
    visit "/hangman"

    make_guess "t"

    expect_answer_to_be "_ _ _ _ _ _ _ _"
    expect_trash_to_contain "t"
  end

  scenario "player makes a duplicate guess"

  scenario "player loses all lives"

  scenario "player guesses all letters"

end