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
    .group("merchants.id")
    .first
  end
end
