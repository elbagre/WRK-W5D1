require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  let!(:buddy) { FactoryGirl.create(:user) }

  scenario "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', with: "testing_username"
      fill_in 'password', with: "biscuits"
      click_on "Create User"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content("testing_username")
    end

  end

end

feature "logging in" do
  let!(:buddy) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_session_url
    fill_in 'username', with: "#{buddy.username}"
    fill_in 'password', with: "#{buddy.password}"
    click_on "Sign In"
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content("#{buddy.username}")
  end


end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit new_user_url
    expect(page).not_to have_content("Sign Out")
  end


  scenario "doesn't show username on the homepage after logout" do
    visit new_user_url
    expect(page).not_to have_content("You are logged in as")
  end

end
