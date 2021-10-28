class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true
  validates_presence_of :merchant_id, presence: true

  # def self.find_all_prices(min, max)
  #   if min && !max
  #     where("unit_price >= ?", min)
  #     .order(:name)
  #   elsif max && !min
  #     where("unit_price <= ?", max)
  #     .order(:name)
  #   else
  #     where('unit_price < ? AND unit_price > ?', max, min)
  #     .order(:name)
  #   end
  # end

  def self.find_by_min(min)
    where("unit_price >= ?", min)
    .order(:name)
    .first
  end

  def self.find_by_max(max)
    where("unit_price <= ?", max)
    .order(:name)
    .first
  end

  def self.find_by_both(min, max)
    where('unit_price < ? AND unit_price > ?', max, min)
       .order(:name)
       .first
  end

  def self.find_item_name(params)
    where("name ILIKE ?", "%#{params}%")
    .first
  end

  def self.revenue_ranking(qty =10)
    joins(invoice_items: {invoice: :transactions})
    .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .group("items.id")
    .order("revenue desc")
    .limit(qty)
  end
end
