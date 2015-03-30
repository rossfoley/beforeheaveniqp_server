require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password '12341234'
    password_confirmation '12341234'
  end
end
