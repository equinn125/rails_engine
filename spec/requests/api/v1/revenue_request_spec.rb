require 'rails_helper'

describe 'Revenue API endpoint' do
  it 'can find total revenue for a given merchant' do
    merchant_1 =  create(:merchant, name: 'Krusty Krab')
    customer =  create(:customer)
    invoice =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
    item_1 = create(:item, name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
    item_2 = create(:item, name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
    invoice_item1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id, quantity: 5, unit_price: 1200)
    invoice_item2 = create(:invoice_item,item_id: item_2.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    transaction = create(:transaction, invoice_id: invoice.id, result: "success")

    get "/api/v1/revenue/merchants/#{merchant_1.id}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data]).to be_a(Hash)
    expect(merchant[:data][:attributes]).to have_key(:revenue)
  end

  it 'has a sad path for merchants that are not found' do
    get "/api/v1/revenue/merchants/0"
    expect(response.status).to eq(404)
  end

  describe 'merchants with most revenue end point' do
    it 'finds the amount of merchants specified in descending order' do
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
      get "/api/v1/revenue/merchants?quantity=2"
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to eq(2)
    end

    it 'has a sad path for bad params' do
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
      get "/api/v1/revenue/merchants?quantity=-2"
      expect(response.status).to eq(400)
    end

    it 'has a sad path for missing params' do
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
      get "/api/v1/revenue/merchants?quantity"
      expect(response.status).to eq(400)
    end
  end

  describe 'item revenue endpoint' do
    it 'returns a list of items sorted by revenue' do
      merchant_1 =  create(:merchant, name: 'Krusty Krab')
      customer =  create(:customer)
      invoice_1 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
      invoice_2 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
      invoice_3 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
      item_1 = create(:item, name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = create(:item, name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      item_3 = create(:item, name: "Blue Shirt", description: "a shirt that is blue", unit_price: 1100, merchant_id: merchant_1.id)
      item_4 = create(:item, name: "green shirt", description: "a shirt, tht is green", unit_price: 1000, merchant_id: merchant_1.id)
      item_5 = create(:item, name: "yellow shirt", description: "its a shirt and it is yellow", unit_price: 1000, merchant_id: merchant_1.id)
      invoice_item1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 1200)
      invoice_item2 = create(:invoice_item,item_id: item_2.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 1000)
      invoice_item3 = create(:invoice_item,item_id: item_3.id, invoice_id: invoice_2.id, quantity: 15, unit_price: 1100)
      invoice_item4 = create(:invoice_item,item_id: item_4.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 1300)
      invoice_item5 = create(:invoice_item,item_id: item_5.id, invoice_id: invoice_3.id, quantity: 5, unit_price: 1000)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
      get "/api/v1/revenue/items?quantity=2"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to eq(2)
    end

    it 'has a sad path for blank quantity' do
      merchant_1 =  create(:merchant, name: 'Krusty Krab')
      customer =  create(:customer)
      invoice_1 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
      invoice_2 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
      invoice_3 =  create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id )
      item_1 = create(:item, name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = create(:item, name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      item_3 = create(:item, name: "Blue Shirt", description: "a shirt that is blue", unit_price: 1100, merchant_id: merchant_1.id)
      item_4 = create(:item, name: "green shirt", description: "a shirt, tht is green", unit_price: 1000, merchant_id: merchant_1.id)
      item_5 = create(:item, name: "yellow shirt", description: "its a shirt and it is yellow", unit_price: 1000, merchant_id: merchant_1.id)
      invoice_item1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 1200)
      invoice_item2 = create(:invoice_item,item_id: item_2.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 1000)
      invoice_item3 = create(:invoice_item,item_id: item_3.id, invoice_id: invoice_2.id, quantity: 15, unit_price: 1100)
      invoice_item4 = create(:invoice_item,item_id: item_4.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 1300)
      invoice_item5 = create(:invoice_item,item_id: item_5.id, invoice_id: invoice_3.id, quantity: 5, unit_price: 1000)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
      get "/api/v1/revenue/items?quantity=" ""
      expect(response.status).to eq(400)
    end
  end
end
