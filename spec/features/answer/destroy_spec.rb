require 'rails_helper'

feature 'Delete answer.', "
  Only the author can delete his answer,
  but can not delete someone else's answer.
" do

  given(:user) { create(:user) }
  given(:answer) { create(:answer) }

  describe 'Authenticated user' do
    scenario 'is the author' do
      sign_in(answer.author)
      visit question_path(answer.question)
      expect(page).to have_content answer.body
      click_on 'Delete answer'
      expect(page).to have_no_content answer.body
    end

    scenario 'is not the author' do
      sign_in(user)
      visit question_path(answer.question)
      expect(page).to have_no_link('Delete answer', href: answer_path(answer))
    end
  end

  scenario 'Unauthenticated user' do
    visit question_path(answer.question)
    expect(page).to have_no_link('Delete answer', href: answer_path(answer))
  end
end
