class ItemRevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :item_revenue
  set_id :id
  attributes :name, :description, :unit_price, :merchant_id, :revenue
end
