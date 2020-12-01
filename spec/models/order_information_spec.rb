require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    @order_info = FactoryBot.build(:order_information)
  end

  describe '商品購入機能' do
    context '商品購入:正常系' do
      it '必要な情報を適切に入力すると、商品の購入ができること' do
        expect(@order_info).to be_valid
      end

      it '必要な情報を適切に入力し、建物名は空欄でも商品の購入ができること' do
        @order_info.address_building_name = ''
        expect(@order_info).to be_valid
      end

      it '必要な情報を適切に入力し、建物名はnilでも商品の購入ができること' do
        @order_info.address_building_name = nil
        expect(@order_info).to be_valid
      end
    end

    context '商品購入:異常系(必須チェック:空だとエラー)' do
      it 'クレジットカード情報は必須であること(tokenが空だとエラー)' do
        @order_info.token = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号は必須であること' do
        @order_info.zipcode = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Zipcode can't be blank")
      end

      it '都道府県は必須であること' do
        @order_info.prefecture_id = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村は必須であること' do
        @order_info.city = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("City can't be blank")
      end

      it '番地は必須であること' do
        @order_info.address = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号は必須であること' do
        @order_info.telephone = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Telephone can't be blank")
      end
    end

    context '商品購入:異常系(必須チェック:nilだとエラー)' do
      it 'クレジットカード情報は必須であること(tokenがnilだとエラー)' do
        @order_info.token = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号は必須であること' do
        @order_info.zipcode = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Zipcode can't be blank")
      end

      it '都道府県は必須であること' do
        @order_info.prefecture_id = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村は必須であること' do
        @order_info.city = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("City can't be blank")
      end

      it '番地は必須であること' do
        @order_info.address = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号は必須であること' do
        @order_info.telephone = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Telephone can't be blank")
      end
    end

    context '商品購入:異常系(整合性)' do
      it '郵便番号:フォーマットが合わない場合はエラー(ハイフン要。123-4567となる)' do
        @order_info.zipcode = '1234567'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Zipcode is invalid. Include hyphen(-)')
      end

      it '電話番号:ハイフンは不要で、11桁以内であること(09012345678が正。桁オーバーはエラー)' do
        @order_info.telephone = '090123456789'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Telephone is invalid')
      end

      it '電話番号にはハイフンは不要で、11桁以内であること(09012345678が正。ハイフンはエラー)' do
        @order_info.telephone = '090-2345678'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Telephone is invalid')
      end
    end
  end
end
