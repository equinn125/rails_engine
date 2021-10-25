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

  private
  def limit_amount
    params.fetch(:per_page, 20).to_i
  end

  def page_offset
    if params[:page].to_i  > 0
      params[:page].to_i - 1
    else
    0
    end
  end
end
