class Merchant < ApplicationRecord
  has_many :items

  def self.find_all_name(search_params)
    where("name ILIKE ?", "%#{search_params}%")
    .order(:name)
  end
end
