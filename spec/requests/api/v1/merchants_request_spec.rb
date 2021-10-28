require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 20)
    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)
    expect(merchants).to be_a(Hash)
    expect(merchants[:data]).to be_a(Array)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq('merchant')
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends a default of 20 merchants at a time' do
    create_list(:merchant, 100)
    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(20)
  end

  it 'can send 20 merchants per page' do
    create_list(:merchant, 30)
    get '/api/v1/merchants', params:{page: 1}
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(20)

    get '/api/v1/merchants', params:{page: 2}
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(10)
  end

  it 'can send the correct amount of results based on the per page perameter' do
    create_list(:merchant, 55)
    get '/api/v1/merchants', params:{per_page: 50}
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(50)
  end

  it 'sends an empty array if no data is availible' do
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(0)
    expect(merchants[:data]).to be_a(Array)
    expect(merchants[:data]).to eq([])
  end

  describe 'merchant show request' do
    it 'can get one merchant by its id' do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"
      merchant= JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(merchant[:data]).to be_a(Hash)
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_a(String)
      expect(merchant[:data][:type]).to eq('merchant')
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to be_a(Hash)
    end

    it 'has a 404 error message if id is bad' do
    merchant = create(:merchant)
      get "/api/v1/merchants/2"
      expect(response.status).to eq(404)
    end
  end

  describe 'merchant by most items endpoint' do
    it 'can return a specified quantity of merchants ranked by most items sold' do
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
      get "/api/v1/merchants/most_items?quantity=2"
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to eq(2)
    end

    it 'sends an error if quantity is not specified' do
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
      get "/api/v1/merchants/most_items?quantity"
      expect(response.status).to eq(400)
    end
  end
end
