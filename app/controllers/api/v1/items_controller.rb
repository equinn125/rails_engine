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

    def update
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: ItemSerializer.new(item), status: 200
      elsif item.merchant.nil?
        render json: '{"error": "not_found"}', status: 404
      else
      end
    rescue ActiveRecord::RecordNotFound
      render json: '{"error": "not_found"}', status: 404
    end
  end

    def destroy
      render json: Item.delete(params[:id]) 
    end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
