require 'rails_helper'

describe 'Merchant find all API' do
  it 'can find all nmerchants by name' do
    create(:merchant, name: 'Krusty Krab')
    create(:merchant, name: 'Chum Bucket')
    create(:merchant, name: 'Turing')
    create(:merchant, name: 'Ring World')

    get "/api/v1/merchants/find_all?name=ring"
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(2)
  end

  it 'returns an empty hash if nothing matches' do
    create(:merchant, name: 'Krusty Krab')
    create(:merchant, name: 'Chum Bucket')
    get "/api/v1/merchants/find_all?name=ring"
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants).to eq({data: [] })
    expect(merchants[:data]).to eq([])
  end
end
