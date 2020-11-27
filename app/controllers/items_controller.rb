class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :edit_user_check, only: [:edit]

  def index
    @items = Item.all.order('created_at desc')
  end

  def show
    @item = Item.find(params[:id])
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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
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

  def edit_user_check
    edit_user = Item.find(params[:id])
    redirect_to action: :index unless user_signed_in? && current_user.id == edit_user.user_id
  end
end
