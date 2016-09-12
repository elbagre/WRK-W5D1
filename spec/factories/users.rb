FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name }
    password "starwars"
    session_token { "#{SecureRandom.urlsafe_base64(16)}" }
  end
end
