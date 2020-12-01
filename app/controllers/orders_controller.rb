class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_info = OrderInformation.new
  end

  def create
  end


end
