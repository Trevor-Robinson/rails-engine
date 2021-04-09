class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_revenue
  set_id :id
  attributes :revenue
end
