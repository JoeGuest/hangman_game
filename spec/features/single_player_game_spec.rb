require "spec_helper"

feature "single player game" do
  scenario "player starts game" do
    visit "/"

    click_link "Start Game"

    expect(page).to have_css "#answer"
  end
end