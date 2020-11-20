class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 40 }
  validates :email,    uniqueness: true
  validates :encrypted_password, format: {with:  /\A[a-zA-Z0-9]+\z/, message: '半角英数字を使用してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角文字(漢字・ひらがな・カタカナ)を使用してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ン]+\z/, message: '全角文字(カタカナ)を使用してください' } do
    validates :kana_last_name
    validates :kana_first_name
  end

  validates :birthday, presence: true

end
