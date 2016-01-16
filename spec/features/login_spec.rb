require 'feature_helper'

RSpec.feature 'Login', js: true do
  scenario 'allows a registered user to log in' do
    registered_email = 'registered@example.com'
    password = 'password'

    User.create! email: registered_email, password: password

    visit '/'

    expect(page).to have_link 'Log in'
    expect(page).not_to have_button 'Log out'

    click_link 'Log in'

    expect(page).to have_text 'Log in'

    fill_in 'Email', with: registered_email
    fill_in 'Password', with: password

    click_button 'Log in'

    expect(page).to have_text 'Welcome to the Expenser!'
    # expect(page).to have_text 'existing_user@example.com'

    expect(page).not_to have_link 'Log in'
    expect(page).to have_button 'Log out'
  end

  scenario 'does not not allow users to log in with incorrect details' do
    page.driver.header 'Referer', 'https://example.com/login'

    registered_email = 'registered@example.com'
    password = 'password'

    User.create email: registered_email, password: password

    visit '/'

    click_link 'Log in'

    expect(page).to have_text 'Log in'

    fill_in 'Email', with: registered_email
    fill_in 'Password', with: 'INCORRECT'

    click_button 'Log in'

    error = 'The provided authorization grant is invalid, expired, revoked,'\
            ' does not match the redirection URI used in the authorization'\
            ' request, or was issued to another client.'

    within '#errors' do
      expect(page).to have_text 'Log in was unsuccessful!'
      expect(page).to have_text error
    end
  end
end
