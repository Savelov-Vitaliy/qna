require 'rails_helper'

feature 'New user can sign up.', %q{
  A new user can register
  to be able to ask questions
  or respond to others.
} do

  given(:user) { build(:user) }

  background { visit new_user_registration_path }

  scenario 'New user tries to signed up.' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'You have signed up successfully'
  end

  scenario 'Invalid login or password.' do
    fill_in 'Email', with: 'wrongemailtestcom'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(page).to have_content 'prohibited this user from being saved'
  end

end
