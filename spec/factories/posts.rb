# spec/factories/posts.rb
FactoryBot.define do
  factory :post do
    title { "テスト投稿" }
    content { "これはテストの投稿です。" }
    association :user
  end
end
