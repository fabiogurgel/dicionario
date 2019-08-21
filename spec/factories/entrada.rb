FactoryGirl.define do
  factory :entrada, class: Entrada do
    sequence(:word)   { |n| "#{n}#{Faker::Lorem.word}" }
    grammar_group     { Faker::Lorem.word }
  end
end
