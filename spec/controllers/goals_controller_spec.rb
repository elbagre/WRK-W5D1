require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  before(:each) do
    allow_message_expectations_on_nil
  end

  describe "GET#new" do

    feature "the goal setting process" do

      scenario "render 'Set a Goal' page" do
        visit new_goal_url
        expect(response).to render_template("new")
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST #create" do
    let(:kangaroojack) { User.create!(username: 'kangaroo_jack', password: 'kangaroo') }

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to(new_session_url)
      end
    end

    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { kangaroo_jack }
      end

      context "with invalid params" do
        it "validates the presence of title and body" do
          post :create, goal: { title: "invalid" }
          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
        end
      end

      context "with valid params" do
        it "validates the presence of title and body" do
          post :create, goal: {
            title: "I want to be a fisherman",
            details: "Pay ain't good, but I don't have to showr for months",
            visibility: false,
            completed: false
          }
          expect(response).to redirect_to(goal_url(Goal.last))
        end
      end
    end
  end
end


# describe "POST#create" do
#
#   let!(:buddy) { FactoryGirl.create(:user) }
#
#   before(:each) do
#     visit new_session_url
#     fill_in 'username', with: "#{buddy.username}"
#     fill_in 'password', with: "#{buddy.password}"
#     click_on "Sign In"
#   end
#
#   context "with valid params" do
#     it "redirects to the goal show page" do
#       post :create, goal: {
#         title: "I want to be a fisherman",
#         details: "they pay ain't good but i don't have to shower",
#         user_id: "#{buddy.id}",
#         visibility: true,
#         completed: false
#       }
#       expect(response).to redirect_to(goal_url(Goal.last))
#     end
#   end
# end
