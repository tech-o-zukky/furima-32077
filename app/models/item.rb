class Item < ApplicationRecord
    # バリデーションが必須項目のみ
    with_options presence: true do
      validates :item_name
      validates :item_explanation
      validates :image
    end

    # ActiveHash利用カラムのバリデーション
    with_options presence: true,  numericality: { other_than: 1 } do
      validates :item_category_id
      validates :item_status_id
      validates :item_shipping_fee_status_id
      validates :prefecture_id
      validates :item_scheduled_delivery_id
    end
    
    # 価格のバリデーション
    validates :sell_price, presence: true, 
                           numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    
    validates :user,  null: false,  foreign_key: true
  
    belongs_to :user
end
