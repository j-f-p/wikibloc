FactoryBot.define do
  factory :user do
    sequence :email { |n| "test#{n}@example.com" }
    password RandomData.random_word(8,16)
    confirmed_at Time.now
  end
end
