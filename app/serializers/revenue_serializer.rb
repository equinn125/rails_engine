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
end
