class OrderInformation
  include ActiveModel::Model

  attr_accessor :token, :card_no, :card_exp_month, :card_exp_year, :card_cvc,
                :zipcode, :prefecture_id, :city,
                :address, :address_building_name, :telephone, :user_id, :item_id

  #バリデーション:カード情報
  validates :token, presence: true

  #バリデーション:addresses
  with_options presence: true do
    validates :zipcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" } 
    validates :city
    validates :address
    validates :telephone, format: { with: /\A\d{,11}\z/ }
  end

  #購入時情報の保存処理
  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)    
    Address.create(zipcode: zipcode, prefecture_id: prefecture_id, city: city, address: address, address_building_name: address_building_name, telephone: telephone, purchase_id: purchase.id )
  end
end