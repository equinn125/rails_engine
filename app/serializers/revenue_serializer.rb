class RevenueSerializer

  def self.merchant_revenue(merchant)
  {
  "data": {
    "id": merchant.id.to_s,
    "type": "merchant_revenue",
    "attributes": {
      "revenue": merchant.revenue
      }
    }
  }
  end

  def self.top_merchant(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": merchant.id.to_s,
          "type": 'merchant_name_revenue',
          "attributes": {
            "name": merchant.name,
            "revenue": merchant.revenue
          }
        }
      end
    }
  end

  def self.top_item(items)
    {
      "data": items.map do |item|
        {
          "id": item.id.to_s,
          "type": "item_revenue",
          "attributes": {
            "name": item.name,
            "description": item.description,
            "unit_price": item.unit_price,
            "merchant_id": item.merchant_id,
            "revenue": item.revenue
          }
        }
    end
    }
  end
end
