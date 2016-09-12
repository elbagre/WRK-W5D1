# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  details    :text             not null
#  user_id    :integer          not null
#  visibility :boolean          not null
#  completed  :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    
  end
end
