class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.limit(limit_amount).offset(limit_amount * page_offset)
    render json: ItemSerializer.new(items)
  end
end
