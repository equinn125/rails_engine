require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
  end

  it 'finds all merchants with partial name matches' do
  m1=  create(:merchant, name: 'Turing')
  m3=  create(:merchant, name: 'Ring World')
  m2=  create(:merchant, name: 'Krusty Krab')
  m4= create(:merchant, name: 'Chum Bucket')
    expect(Merchant.find_all_name('Ring')).to eq([m3, m1])
    expect(Merchant.find_all_name('Ring')).to_not eq([m2,m4])
  end

  it 'ranks merchants based on revenue and given quantity' do
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
    expect(Merchant.most_revenue(2)).to eq([merchant_2, merchant_1])
    expect(Merchant.most_revenue(2).first.revenue).to eq(29500.0)
  end

  it 'finds the revenue for a merchant' do
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
    expect(Merchant.merchant_revenue(merchant_1.id)).to eq(merchant_1)
    expect(Merchant.merchant_revenue(merchant_1.id).revenue).to eq(16000.0)
  end

  it 'ranks merchants by most sold items' do
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
    expect(Merchant.most_merchant_items(2)).to eq([merchant_2, merchant_1])
  end
end
