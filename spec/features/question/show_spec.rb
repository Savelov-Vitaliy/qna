require 'rails_helper'

feature 'User can view questions and answers to it.', '
  Any unauthenticated user
  can view questions and answers to it.
' do

  given(:question) { create(:question) }
  given(:answers) { create_list(:answer, 3, question) }
  given(:user) { create(:user) }

  after do
    visit question_answers_path(question_id: question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    question.answers.map { |answer| expect(page).to have_content answer.body }
  end

  scenario 'User view questions and answers' do
    sign_in(user)
  end

  scenario 'Unauthenticated user view questions and answers' do
  end
end
