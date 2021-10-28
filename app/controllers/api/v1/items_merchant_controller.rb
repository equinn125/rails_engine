class Api::V1::ItemsMerchantController < ApplicationController
  def show
    if item = Item.find_by(id: params[:id])
    render json: MerchantSerializer.new(item.merchant)
  else
    render json: '{"error": "not_found"}', status: 404
    end
  end
end
