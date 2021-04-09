class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    quantity = 10 if quantity == nil
    Item.select(" items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: [:transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
 end

 def self.find_by_name(name)
  Item.where("items.name ILIKE ?", "%#{name}%").order("name").limit(1)
 end

end
