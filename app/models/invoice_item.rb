class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many   :transactions, through: :invoice

  def self.revenue_date_range(start_time, end_time)
    InvoiceItem
    .joins(:transactions)
    .merge(Transaction.successful)
    .where(created_at: start_time.to_time..end_time.to_time.end_of_day)
    .sum("unit_price * quantity")
  end
  def self.revenue_by_week
    InvoiceItem
    .group("DATE_TRUNC('week', invoice_items.created_at)")
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
