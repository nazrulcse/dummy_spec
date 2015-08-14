require 'rails_helper'
describe 'Test User Authentication Process', :type => :controller do
  before :each do
    @user = User.create!(:email => 'user1@example.com', :password => '123456789')
  end

  it 'It should register a new user' do
    visit 'users/sign_up'
    within('#new_user') do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password confirmation', :with => 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Sign Out'
  end

  it 'It should redirect user for password validation with register a new user' do
    visit 'users/sign_up'
    within('#new_user') do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => '12547'
      fill_in 'Password confirmation', :with => '12547'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Password is too short'
  end

  it 'It should sign in user' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', :with => 'user1@example.com'
      fill_in 'Password', :with => '123456789'
    end
    click_button 'Log in'
    expect(page).to have_content 'Sign Out'
  end

  it 'It should show invalid email or password for sign in user' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', :with => 'user1@example.com'
      fill_in 'Password', :with => '123456'
    end
    click_button 'Log in'
    expect(page).to have_content 'Forgot your password?'
  end

  it 'It should sign in and sign out an user' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', :with => 'user1@example.com'
      fill_in 'Password', :with => '123456789'
    end
    click_button 'Log in'
    expect(page).to have_content 'Sign Out'
    click_link 'Sign Out'
    expect(page).to have_content 'Registration'
  end

end