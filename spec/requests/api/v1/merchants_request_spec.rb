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
end
