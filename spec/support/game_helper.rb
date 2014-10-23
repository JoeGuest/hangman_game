module GameHelper
  def make_guess(guess)
    fill_in "guess", with: guess
    click_button "Guess!"
  end

  def expect_answer_to_be(answer)
    within("#answer") do
      expect(page).to have_content answer
    end
  end

  def expect_trash_to_contain(letter)
    within("#trash") do
      expect(page).to have_content letter
    end
  end
end