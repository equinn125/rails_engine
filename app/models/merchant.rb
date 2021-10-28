class Merchant < ApplicationRecord
  has_many :items

  def self.find_all_name(search_params)
    where("name ILIKE ?", "%#{search_params}%")
    .order(:name)
  end

  def self.merchant_revenue(merchant_id)
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where("transactions.result = ? AND merchants.id = ?", "success",merchant_id)
    .where("invoices.status = ?", "shipped")
    .group("merchants.id")
    .first
  end

  def self.most_revenue(quantity)
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .group("merchants.id")
    .order("revenue desc")
    .limit(quantity)
  end

  def self.most_merchant_items(quantity = 5)
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.quantity) AS amount")
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .group("merchants.id")
    .order("amount desc")
    .limit(quantity)
  end
end
