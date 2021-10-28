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

    def find
      if sad_params(params)
        render json: '{"error": "bad_request"}', status: 400
    elsif params[:name] && !price?
        item = Item.find_item_name(params[:name])
        render json: ItemSerializer.new(item) if !item.nil?
        render json: { data: {} } if item.nil?
      elsif  !params[:name] && params[:min_price] && !params[:max_price]
      item = Item.find_by_min(params[:min_price])
      render json: ItemSerializer.new(item) if !item.nil?
      render json: { data: {} } if item.nil?
    elsif  !params[:name] && !params[:min_price] && params[:max_price]
      item = Item.find_by_max(params[:max_price])
      render json: ItemSerializer.new(item)
      render json: { data: {} } if item.nil?
    elsif  !params[:name] && params[:min_price] && params[:max_price]
      item = Item.find_by_both(params[:min_price], params[:max_price])
      render json: ItemSerializer.new(item)
      render json: { data: {} } if item.nil?
      else
      end
    end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
  def price?
    params[:min_price] || params[:max_price]
  end

  def sad_params(params)
    if params[:name] && price?
      true
    elsif price?.to_i < 0
      true
    else
      false
    end
  end
end
