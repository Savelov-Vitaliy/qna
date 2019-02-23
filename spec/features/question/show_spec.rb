require 'rails_helper'

feature 'User can view questions and answers to it.', '
  Any unauthenticated user
  can view questions and answers to it.
' do

  given(:question) { create(:question) }
  given(:answers) { create_list(:answer, 3, question) }
  given(:current_user) { create(:user) }

  scenario 'User view questions and answers' do
    sign_in(current_user)
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    question.answers.each { |answer| expect(page).to have_content answer.body }
  end

  scenario 'Unauthenticated user view questions and answers' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    question.answers.each { |answer| expect(page).to have_content answer.body }
  end
end
