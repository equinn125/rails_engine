class ApplicationController < ActionController::API
  # helper_method :limit_amount, :page_offset
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
