FactoryBot.define do
  factory :book do
    isbn { "MyString" }
    copies { 1 }
    name { "MyString" }
    late_return_penalty { 1 }
    publisher_author { nil }
  end
end
