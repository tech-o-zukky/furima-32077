class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order("created_at desc")
  end

  def show

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name, :item_explanation, :image,
      :item_category_id, :item_status_id, :item_shipping_fee_status_id,
      :prefecture_id, :item_scheduled_delivery_id, :sell_price
    ).merge(user_id: current_user.id)
  end

end
