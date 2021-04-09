class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  set_type :unshipped_order
  set_id :id
  attributes :potential_revenue
end
