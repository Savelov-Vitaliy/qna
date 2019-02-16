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
      visit answer_path(id: answer)
      click_on 'Delete answer'
      expect(page).to have_no_content answer.body
    end

    scenario 'is not the author' do
      sign_in(user)
      visit answer_path(id: answer)
      click_on 'Delete answer'
      expect(page).to have_content 'You don`t have permission to delete this answer.'
    end
  end

  scenario 'Unauthenticated user' do
    visit answer_path(id: answer)
    click_on 'Delete answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
