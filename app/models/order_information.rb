class OrderInformation
  include ActiveModel::Model

  attr_accessor :token, :card_no, :card_exp_month, :card_exp_year, :card_cvc,
                :zipcode, :prefecture_id, :city,
                :address, :address_building_name, :telephone

  #バリデーション:カード情報
  with_options presence: true do
    validates :card_no, format: { with: /\A(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})\z/ }
    validates :card_exp_month, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
    validates :card_exp_year
    validates :card_cvc
  end

  #バリデーション:addresses
  with_options presence: true do
    validates :zipcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" } 
    validates :city
    validates :address
    validates :telephone, format: { with: /\A\d{10,11}\z/ }
  end

end