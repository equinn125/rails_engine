class Api::V1::RevenueController < ApplicationController
  def total_merchant_revenue
    if Merchant.find_by(id: params[:id])
      merchant = Merchant.merchant_revenue(params[:id])
    render json: RevenueSerializer.merchant_revenue(merchant)
  else
    render json: {error: "not-found"}, status: 404
    end
  end
end
