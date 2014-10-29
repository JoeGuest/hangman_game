When(/^player uses show definition powerup$/) do
  @score_before = find("#score").text
  click_link "show definition"
  @score_after = find("#score").text
end

Then(/^score is reduced by cost of powerup$/) do
  expect @score_before > @score_after
end

Then(/^definition is shown to user$/) do
  expect(page).to have_selector("#definition")
end