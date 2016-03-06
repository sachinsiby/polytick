FactoryGirl.define do
  factory :user do
    party "Independent"
    name "John Doe"
    email "john@doe.com"
  end

  factory :state do
    name "Washington"
    max_republican_delegates { Random.rand(100)}
    max_democratic_delegates { Random.rand(100)}
   end
end
