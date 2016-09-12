require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:buddy) { FactoryGirl.create(:user) }

  describe "GET#new" do
    feature "the signup process" do
      scenario "renders 'Sign Up' page" do
        visit new_user_url
        expect(response).to render_template("new")
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST#create" do

    context "with valid params" do
      it "redirects to the user show page" do
        post :create, user: {username: "teehee", password: "catsfrom"}
        expect(response).to redirect_to(user_url(User.last))
        # expect(response).to have_http_status(200)
      end
    end

    context "invalid params" do
      it "validates presence of username and password" do
        post :create, user: { username: "", password: "and" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end

  feature "GET#show" do
    scenario "renders the user#show page" do
      post :create, user: { username: "hello", password: "worlddddd" }
      visit user_url(User.last)
      expect(response).to render_template("show")
    end
  end
end


#   visit new_user_url
#   fill_in 'username', with: ""
#   fill_in 'password', with: "and"
#   click_on "Sign Up"
# end

# feature "signing up a user" do
#   before(:each) do
#     visit new_user_url
#     fill_in 'username', :with => "#{buddy.username}"
#     fill_in 'password', :with => "#{buddy.password}"
#     click_on "Sign Up"
#   end
#
#   scenario "redirects to user page after signup" do
#     expect(page).to redirect_to(user_url(buddy))
#   end
#
#   scenario "signs in new user" do
#     expect(:current_user).to eq(buddy)
#   end
