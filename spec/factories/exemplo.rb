FactoryGirl.define do
  factory :exemplo, class: Exemplo do
    text   { Faker::Lorem.paragraph }
  end
end
