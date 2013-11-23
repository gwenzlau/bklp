require 'faker'

FactoryGirl.define do
  factory :discussion do
    book_id 1928
    quote { Faker::Lorem.sentence }
    page 10
    pages_total 105
  end
end
