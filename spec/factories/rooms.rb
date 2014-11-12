require 'faker'

FactoryGirl.define do
  factory :room do
    name { Faker::Name.name }
    genre { Faker::Commerce.department }
    visits 0
    member_ids []
  end
end
