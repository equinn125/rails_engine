class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.limit(limit_amount).offset(limit_amount * page_offset)
    render json: MerchantSerializer.new(merchants)
  end

  def show

    if merchant = Merchant.find_by(id: params[:id])
    render json: MerchantSerializer.new(merchant)
  else
    render json: '{"error": "not_found"}', status: 404
    end
  end

  def find_all
    merchants = Merchant.find_all_name(params[:name])
    if merchants.nil?
      render json: {data: {}}
    else
    render json: MerchantSerializer.new(merchants)
    end
  end

end
