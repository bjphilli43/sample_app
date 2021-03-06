include ApplicationHelper

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in(user, options={})
  if options[:no_capybara]
    #Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    valid_signin(user)
  end
end

def valid_signup
  fill_in "Name", with:"Example User"
  fill_in "Email", with: "user@example.com"
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def submit_user(email)
  User.find_by(email: email)
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_profile_link do |user|
  match do |page|
    expect(page).to have_link('Profile', href: user_path(user))
  end
end

RSpec::Matchers.define :have_signin_link do
  match do |page|
    expect(page).to have_link('Sign in', href: signin_path)
  end
end

RSpec::Matchers.define :have_signout_link do
  match do |page|
    expect(page).to have_link('Sign out', href: signout_path)
  end
end