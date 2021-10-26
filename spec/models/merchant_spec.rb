require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    xit {should have_many :items}
  end
end
