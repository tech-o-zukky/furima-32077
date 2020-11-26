require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品:正常系' do
      it '必要な情報を適切に入力すると、商品の出品(登録)ができること' do
        expect(@item).to be_valid
      end
    end

    context '新規登録:異常系(必須入力チェック)' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.item_explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item explanation can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.item_category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end

      it '商品の状態についての情報が必須であること' do
        @item.item_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end

      it '配送料の負担についての情報が必須であること' do
        @item.item_shipping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Item shipping fee status can't be blank")
      end

      it '発送元の地域についての情報が必須であること' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数についての情報が必須であること' do
        @item.item_scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Item scheduled delivery can't be blank")
      end

      it '価格についての情報が必須であること' do
        @item.sell_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Sell price can't be blank")
      end

    end

    context '新規登録:異常系(価格のチェック)' do
      it '価格の範囲が、¥300~¥9,999,999の間でなければエラー(¥300より小さい場合)' do
        @item.sell_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Sell price must be greater than or equal to 300")
      end

      it '価格の範囲が、¥300~¥9,999,999の間でなければエラー(¥9,999,999より大きい場合)' do
        @item.sell_price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Sell price must be less than or equal to 9999999")
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.sell_price = "５００" #全角で入力
        @item.valid?
        expect(@item.errors.full_messages).to include("Sell price is not a number")
      end
    end
  end
end
