require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of 20 merchants at a time' do
    create_list(:merchant, 20)
    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body)
  end
end
