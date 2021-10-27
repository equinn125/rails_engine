require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
     it { should belong_to(:merchant) }
  end

  it 'finds a item by name' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4.99, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5.99, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6.99, merchant_id: merchant.id)

    expect(Item.find_item_name('sham')).to eq([item1])
  end

  xit 'finds item by minimum price' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)
    params = { min_params: 3}
    expect(Item.find_by_min(params)).to eq([item1, item2, item3])
  end

  xit 'finds item by maximum price' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)
    params = { max_params: 7}
    expect(Item.find_by_max(params)).to eq([item1,item2,item3])
  end

  xit 'finds item within min and maximum price' do
    merchant = create(:merchant)
    item1 = create(:item, name: 'shampoo', description: 'shampoo for curly hair',unit_price: 4, merchant_id: merchant.id)
    item2 =  create(:item, name: 'conditioner', description: 'conditioner for curly hair',unit_price: 5, merchant_id: merchant.id)
    item3 =  create(:item, name: 'hair oil', description: 'hair oil for curly hair',unit_price: 6, merchant_id: merchant.id)
    params = {min_params:4, max_params: 6}
    expect(Item.find_all_prices(params)).to eq([item1,item2,item3])
  end
end
