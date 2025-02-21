FactoryBot.define do
  factory :fovorite do
    association :user
    association :post
  end
end