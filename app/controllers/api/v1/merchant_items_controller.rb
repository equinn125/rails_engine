class Api::V1::MerchantItemsController < ApplicationController
  def index
  if  merchant = Merchant.find_by(id: params[:id])
    render json: ItemSerializer.new(merchant.items)
  else
    render json: '{"error": "not_found"}', status: 404
    end
  end
end
