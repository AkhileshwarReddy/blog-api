FactoryBot.define do
  factory :user do
    username { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    bio { "MyText" }
    image { "MyString" }
  end
end
