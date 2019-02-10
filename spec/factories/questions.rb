FactoryBot.define do
  sequence :title do |n|
    "Title_#{n}"
  end
  sequence :body do |n|
    "BodyText_#{n}"
  end

  factory :question do
    title
    body

    trait :invalid do
      title { nil }
    end
  end
end
