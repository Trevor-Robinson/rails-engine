class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  set_id :id
  attributes :name
end
