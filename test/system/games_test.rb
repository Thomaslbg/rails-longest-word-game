require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Games"
  # end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid." do
    visit new_url
    page.fill_in 'input', with: 'faefaege'
    click_button("Submit")
    assert_text "Sorry but FAEFAEGE can't be build out of"
  end

  # test "You can fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word." do
  #   visit new_url
  #   page.fill_in 'input', with: 'w'
  #   click_button("Submit")
  #   assert_text "does not seem to be an english word"
  # end

  # test "You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message." do
  #   visit new_url
  #   letters = @letters
  #   page.fill_in 'input', with: 'or'
  #   click_button("Submit")
  #   assert_text "Congratulations #{letters}"
  # end
end
