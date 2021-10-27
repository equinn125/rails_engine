require 'rails_helper'

describe 'Find Item API endpoint' do
  it 'finds an item based on name' do
    merchant = create(:merchant)
    create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4.99, merchant_id: merchant.id)
    create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5.99, merchant_id: merchant.id)
    create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6.99, merchant_id: merchant.id)

    get "/api/v1/items/find?name=shamp"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data]).to be_a Hash
  end

  it 'finds an item based on minimum price' do
    merchant = create(:merchant)
    create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)

    get "/api/v1/items/find?min_price=5"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data]).to be_a Hash
  end
  it 'finds an item based on maximum price' do
    merchant = create(:merchant)
    create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 8, merchant_id: merchant.id)

    get "/api/v1/items/find?max_price=7"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data]).to be_a Hash
  end

  it 'finds an item between minimum and maximum price' do
    merchant = create(:merchant)
    create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)

    get "/api/v1/items/find?min_price=4&max_price=7"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data]).to be_a Hash
  end
end
