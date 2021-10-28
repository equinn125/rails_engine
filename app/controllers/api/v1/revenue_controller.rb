class Api::V1::RevenueController < ApplicationController
  def total_merchant_revenue
    if Merchant.find_by(id: params[:id])
      merchant = Merchant.merchant_revenue(params[:id])
    render json: RevenueSerializer.merchant_revenue(merchant)
  else
    render json: {error: "not-found"}, status: 404
    end
  end

  def merchant_revenue
    if params[:quantity] && params[:quantity].to_i > 0
        merchants = Merchant.most_revenue(params[:quantity])
      render json: RevenueSerializer.top_merchant(merchants)
    else
      render json: {error: "bad_request"}, status: 400
    end
  end
end
