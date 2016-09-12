require 'rails_helper'

RSpec.describe User, type: :model do

  #validations
  describe User do

    let!(:buddy) { FactoryGirl.create(:user) }
    let!(:oscar) { FactoryGirl.create(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  #associations

  #class scope
  describe "::find_by_credentials" do

    let!(:buddy) { FactoryGirl.create(:user) }
    let!(:oscar) { FactoryGirl.create(:user) }

    it "returns the user when given correct credentials" do
      expect(User.find_by_credentials(buddy.username, buddy.password)).to eq(buddy)
    end

    it "returns nil when given incorrect credentials" do
      expect(User.find_by_credentials(oscar.username, "incorrect")).to be_nil
    end
  end


end
