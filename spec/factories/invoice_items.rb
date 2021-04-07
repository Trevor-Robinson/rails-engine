FactoryBot.define do
  factory :invoice_item do
    invoice { nil }
    item { nil }
    quantity { "" }
    unit_price { "9.99" }
  end
end
