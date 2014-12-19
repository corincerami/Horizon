FactoryGirl.define do

  factory :restaurant do
    sequence(:name)        { |n| "#{n}restaurant" }
    address                "66 Kenzel Ave"
    city                   "Nutley"
    state                  "NJ"
    zip_code               "07110"
    sequence(:description) { |n| "#{n}description" }
    category               "Thai"
  end
end
