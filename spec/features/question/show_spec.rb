require 'rails_helper'

feature 'User can write answer to the question.', %q{
  The user,
  being on the question page,
  can write the answer to the question.
} do

  given(:question) { create(:question) }
  given(:user) {create(:user)}

  scenario 'unauthenticated user' do
    visit question_path(id: question.id)
    fill_in 'answer_body', with: 'My answer to this question'
    click_on 'Publish'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(id: question.id)
    end

    scenario 'with valid data.' do
      fill_in 'answer_body', with: 'My answer to this question'
      click_on 'Publish'
      expect(page).to have_content 'My answer to this question'
    end

    scenario 'with empty data.' do
      click_on 'Publish'
      expect(page).to have_content 'Give your answer'
    end
  end

end