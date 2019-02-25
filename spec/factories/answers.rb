FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    question
    association :author, factory: :user, strategy: :build

    trait :invalid do
      body { nil }
    end
  end
end
