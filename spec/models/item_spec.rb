require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
     it { should belong_to(:merchant) }
  end

  it 'finds a item by name' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4.99, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5.99, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6.99, merchant_id: merchant.id)

    expect(Item.find_item_name('sham')).to eq(item1)
  end

  it 'finds item by minimum price' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)

    expect(Item.find_by_min(3)).to eq(item2)
  end

  it 'finds item by maximum price' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)

    expect(Item.find_by_max(7)).to eq(item2)
  end

  it 'finds item within min and maximum price' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)

    expect(Item.find_by_both(4,6)).to eq(item2)
  end

  it 'ranks items by revenue' do
    merchant_1 =  create(:merchant, name: 'Krusty Krab')
    merchant_2 =  create(:merchant, name: 'Chum Bucket')
    merchant_3 =  create(:merchant, name: 'Patricks Rock')
    customer =  create(:customer)
    invoice_1 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
    invoice_2 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id )
    invoice_3 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_3.id )
    item_1 = create(:item, name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
    item_2 = create(:item, name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
    item_3 = create(:item, name: "Blue Shirt", description: "a shirt that is blue", unit_price: 1100, merchant_id: merchant_2.id)
    item_4 = create(:item, name: "green shirt", description: "a shirt, tht is green", unit_price: 1000, merchant_id: merchant_2.id)
    item_5 = create(:item, name: "yellow shirt", description: "its a shirt and it is yellow", unit_price: 1000, merchant_id: merchant_3.id)
    invoice_item1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 1200)
    invoice_item2 = create(:invoice_item,item_id: item_2.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 1000)
    invoice_item3 = create(:invoice_item,item_id: item_3.id, invoice_id: invoice_2.id, quantity: 15, unit_price: 1100)
    invoice_item4 = create(:invoice_item,item_id: item_4.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 1300)
    invoice_item5 = create(:invoice_item,item_id: item_5.id, invoice_id: invoice_3.id, quantity: 5, unit_price: 1000)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
    expect(Item.revenue_ranking(2)).to eq([item_3, item_4])
  end
end
