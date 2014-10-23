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

    fill_in "guess", with: "A"
    click_button "Guess!"  

    within("#answer") do
      expect(page).to have_content "A _ _ _ _ _ _ _"
    end

    fill_in "guess", with: "v"
    click_button "Guess!"

    within("#answer") do
      expect(page).to have_content "A v _ _ _ _ _ _"
    end
  end

  scenario "player makes an incorrect guess"

  scenario "player makes a duplicate guess"

  scenario "player loses all lives"

  scenario "player guesses all letters"

end