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

  def most_items
    if params[:quantity]
      merchants = Merchant.most_merchant_items(params[:quantity])
    render json: MostItemsSerializer.most_items(merchants)
    else
      render json: {error: "bad_request"}, status: 400
    end
  end
end
