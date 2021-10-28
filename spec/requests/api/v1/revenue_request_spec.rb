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
end
