class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true
  validates_presence_of :merchant_id, presence: true

  def self.find_all_prices(min, max)
    if min && !max
      where("unit_price >= ?", min)
      .order(:name)
    elsif max && !min
      where("unit_price <= ?", max)
      .order(:name)
    else
      where('unit_price < ? AND unit_price > ?', max, min)
      .order(:name)
    end
  end

  def self.find_item_name(params)
    where("name ILIKE ?", "%#{params}%")
  end
  #
  # def self.find_by_min(price_params)
  #   where("unit_price >= ?", price_params[:min_params].to_f)
  # end
  #
  # def self.find_by_max(price_params)
  #   where("unit_price <= ?", price_params[:max_params].to_f)
  # end
end
