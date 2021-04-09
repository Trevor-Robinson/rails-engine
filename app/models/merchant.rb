class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    Merchant.select(" merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: [:transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    Merchant.select("merchants.*, SUM(invoice_items.quantity) as count")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("count desc")
    .limit(quantity)
  end

  def merchant_revenue
    Merchant.select(" merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: [:transactions])
    .merge(Transaction.successful)
    .where('merchants.id = ?', id)
    .group("merchants.id")
  end
end
