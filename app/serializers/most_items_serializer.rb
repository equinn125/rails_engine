class MostItemsSerializer
  def self.most_items(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": merchant.id.to_s,
          "type": "items_sold",
          "attributes": {
            "name": merchant.name,
            "count": merchant.amount
          }
        }
      end
    }
  end
end
