class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.limit(limit_amount).offset(limit_amount * page_offset)
    render json: ItemSerializer.new(items)
  end

  def show
  if   item = Item.find_by(id: params[:id])
    render json: ItemSerializer.new(item)
  else
    render json: '{"error": "not_found"}', status: 404
    end
  end
end
