require 'rails_helper'

feature 'User can view a list of questions.', '
  Any unauthenticated user
  can view a list of all questions.
' do

  given!(:questions) { create_list(:question, 3) }
  given(:user) { create(:user) }

  after do
    visit questions_path
    questions.map { |question| expect(page).to have_content question.title }
  end

  scenario 'unauthenticated user' do
  end

  scenario 'authenticated user.' do
    sign_in(user)
  end
end
