class Item < ApplicationRecord
  # ActiveHash用アソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_category
  belongs_to_active_hash :item_status
  belongs_to_active_hash :item_shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :item_scheduled_delivery

  # アソシエーション
  belongs_to :user
  has_one_attached :image

  # バリデーションが必須項目のみ
  with_options presence: true do
    validates :item_name
    validates :item_explanation
    validates :image
  end

  # ActiveHash利用カラムのバリデーション
  with_options presence: true, numericality: { other_than: 0, message: "can't be blank" } do
    validates :item_category_id
    validates :item_status_id
    validates :item_shipping_fee_status_id
    validates :prefecture_id
    validates :item_scheduled_delivery_id
  end

  # 価格のバリデーション
  validates :sell_price, presence: true,
                         numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
