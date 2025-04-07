FactoryBot.define do
  factory :borrow do
    user { nil }
    book { nil }
    borrowed_date { "2025-03-28 06:07:42" }
    estimated_return_date { "2025-03-28 06:07:42" }
    actual_return_date { "2025-03-28 06:07:42" }
  end
end
