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

  def create
  item = Item.new(item_params)
  if item.save
    render json: ItemSerializer.new(item), status: 201
  else
    render json: '{"error": "bad_request"}', status: 400
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
