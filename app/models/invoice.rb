class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.unshipped_revenue(quantity)
    Invoice.select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where('invoices.status != ?', 'shipped')
    .group(:id)
    .order("potential_revenue desc")
    .limit(quantity)
  end
end
