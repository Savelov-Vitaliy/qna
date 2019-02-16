require 'rails_helper'

feature 'User can write answer to the question.', '
  The user,
  being on the question page,
  can write the answer to the question.
' do

  given(:question) { create(:question) }
  given(:current_user) { create(:user) }

  scenario 'Unauthenticated user write answer' do
    visit question_path(id: question.id)
    fill_in 'answer_body', with: 'My answer to this question'
    click_on 'Post answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  describe 'Authenticated user' do
    background do
      sign_in(current_user)
      visit question_path(id: question)
    end

    scenario 'write answer.' do
      fill_in 'answer_body', with: 'My answer to this question'
      click_on 'Post answer'
      expect(page).to have_content 'My answer to this question'
    end

    scenario 'write answer with errors.' do
      click_on 'Post answer'
      expect(page).to have_content 'Give your answer'
    end
  end
end
