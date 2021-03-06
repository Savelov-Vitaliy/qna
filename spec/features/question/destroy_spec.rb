require 'rails_helper'

feature 'Delete question', "
  Only the author can delete his question,
  but can not delete someone else's question
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    scenario 'is the author' do
      sign_in(question.author)
      visit question_path(id: question)
      expect(page).to have_content question.title
      click_on 'Delete question'
      expect(page).to have_no_content question.title
    end

    scenario 'is not the author' do
      sign_in(user)
      visit question_path(id: question)
      expect(page).to have_no_link 'Delete question'
    end
  end

  scenario 'Unauthenticated user' do
    visit question_path(id: question)
    expect(page).to have_no_link 'Delete question'
  end
end
