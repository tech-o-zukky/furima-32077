class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_info = OrderInformation.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_info = OrderInformation.new(order_params)
    if @order_info.valid?
      pay_item
      @order_info.save
      return redirect_to root_path
    else
      render action: :index
    end
  end
  
  private

  def order_params
    params.require(:order_information).permit(
      :zipcode, :prefecture_id, :city,
      :address, :address_building_name, :telephone, :purchase 
    ).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ""  # PAY.JPテスト用
    Payjp::Charge.create(
      amount: @item.sell_price,      # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

end
