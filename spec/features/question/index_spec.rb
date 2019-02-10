require 'rails_helper'

feature 'User can view a list of questions.', %q{
  Any unauthenticated user
  can view a list of all questions.
} do

  given!(:questions) { create_list(:question, 3) }
  given(:user) {create(:user)}

  background { visit questions_path }

  scenario 'unauthenticated user' do
    questions.map { |question| expect(page).to have_content question.title }
  end

  scenario 'authenticated user.' do
    sign_in(user)
    questions.map { |question| expect(page).to have_content question.title }
  end
end