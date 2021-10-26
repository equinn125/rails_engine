require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 20)
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
    expect(items).to be_a(Hash)
    expect(items[:data]).to be_a(Array)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:type)
      expect(item[:type]).to eq('item')
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it 'sends a default of 20 items at a time' do
    create_list(:item, 100)
    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(20)
  end

  it 'can send 20 items per page' do
    create_list(:item, 30)
    get '/api/v1/items', params:{page: 1}
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(20)

    get '/api/v1/items', params:{page: 2}
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(10)
  end

  it 'can send the correct amount of results based on the per page perameter' do
    create_list(:item, 55)
    get '/api/v1/items', params:{per_page: 50}
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(50)
  end
  it 'sends an empty array if no data is availible' do
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(0)
    expect(items[:data]).to be_a(Array)
    expect(items[:data]).to eq([])
  end

  describe 'item show request' do
    it 'can get one merchant by its id' do
      id = create(:item).id
      get "/api/v1/items/#{id}"
      item= JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(item[:data]).to be_a(Hash)
      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)
      expect(item[:data][:type]).to eq('item')
      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to be_a(Hash)
    end

    it 'has a 404 error message if id is bad' do
    merchant = create(:item)
      get "/api/v1/items/2"
      expect(response.status).to eq(404)
    end
  end
end
