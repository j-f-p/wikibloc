FactoryBot.define do
  factory :user do
    email RandomData.random_email
    password RandomData.random_word(8,16)
  end
end