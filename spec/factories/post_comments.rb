FactoryBot.define do
  factory :post_comment do
    comment {"これはテストコメントです。"}
    association :user
    association :post
  end
end
