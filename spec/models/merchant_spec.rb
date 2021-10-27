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
end
