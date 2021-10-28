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
end
