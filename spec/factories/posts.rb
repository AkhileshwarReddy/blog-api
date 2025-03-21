FactoryBot.define do
  factory :post do
    title { "MyString" }
    body { "MyText" }
    video { "MyString" }
    status { "MyString" }
    user { nil }
  end
end
