require 'rails_helper'

feature 'User can write answer to the question.', '
  The user,
  being on the question page,
  can write the answer to the question.
' do

  given(:question) { create(:question) }
  given(:current_user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(current_user)
      visit question_path(question)
    end

    scenario 'Post a answer.' do
      fill_in 'answer_body', with: 'My answer to this question'
      click_on 'Post answer'
      expect(page).to have_content 'My answer to this question'
    end

    scenario 'Post a answer with errors.' do
      click_on 'Post answer'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries post a answer' do
    current_user
    visit question_path(question)
    fill_in 'answer_body', with: 'My answer to this question'
    click_on 'Post answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
