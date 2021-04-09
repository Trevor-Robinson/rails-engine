class MerchantItemsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_name_revenue
  set_id :id
  attributes :name, :count
end
