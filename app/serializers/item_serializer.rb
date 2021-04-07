class ItemSerializer
  include FastJsonapi::ObjectSerializer
  set_type :item
  set_id :id
  attributes :name, :description, :unit_price, :merchant_id
end
