require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録:正常系' do
      it '全ての情報が正しく入力されていれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context '新規登録:異常系 必須項目の確認' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

    context '新規登録:異常系 メールアドレスの確認' do
      it 'emailは重複登録できない(一意性の確認)' do
        @user_a = FactoryBot.create(:user)  # 先に登録しておく
        @user.email = @user_a.email # 登録済みのemailを代入
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@が含まれてなければ登録できない' do
        @user.email = Faker::Lorem.characters(number: 10) # 適当な文字列代入
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
    end

    context '新規登録:異常系 パスワードの確認' do
      it 'passwordは6桁以下だと登録できない' do
        @user.password = 'abc12' # 5桁で入力
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは半角英数字混合でないと登録できない(英字のみの場合)' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordは半角英数字混合でないと登録できない(数字のみの場合)' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordと確認用passwordが一致しなければ登録できない' do
        @user.password_confirmation = @user.password + 'abc' # 確認用パスワードに「abc」の文字を追加
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context '新規登録:異常系 名前の確認' do
      it 'last_nameは、全角（漢字・ひらがな・カタカナ）で入力しなければならない' do
        @user.last_name = 'ﾃｽ山' # 半角ありで入力
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_nameは、全角（漢字・ひらがな・カタカナ）で入力しなければならない' do
        @user.first_name = 'ﾃｽ太郎' # 半角ありで入力
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'kana_last_nameは、全角（カタカナ）で入力しなければならない' do
        @user.kana_last_name = 'ﾃｽﾔﾏ'   # 半角で入力
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name is invalid')
      end

      it 'kana_first_nameは、全角（カタカナ）で入力しなければならない' do
        @user.kana_first_name = 'ﾃｽﾀﾛｳ' # 半角で入力
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name is invalid')
      end

      it 'kana_last_nameは、全角（カタカナ）で入力しなければならない' do
        @user.kana_last_name = '手須山' # 漢字で入力
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name is invalid')
      end

      it 'kana_first_nameは、全角（カタカナ）で入力しなければならない' do
        @user.kana_first_name = '手須太郎'  # 漢字で入力
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name is invalid')
      end
    end
  end
end
