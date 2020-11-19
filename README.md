# README

# テーブル設計

## users テーブル（ユーザー管理テーブル）

| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | null: false |
| encrypted_password  | string | null: false |
| last_name           | string | null: false |
| first_name          | string | null: false |
| kana_last_name      | string | null: false |
| kana_first_name     | string | null: false |
| birthday            | date   | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル（商品テーブル）

| Column                      | Type        | Options                         |
| --------------------------- | ----------- | ------------------------------- |
| item_name                   | text        | null: false                     |
| item_explanation            | text        | null: false                     |
| item_category_id            | integer     | null: false                     |
| item_status_id              | integer     | null: false                     |
| item_shipping_fee_status_id | integer     | null: false                     |
| item_prefecture_id          | integer     | null: false                     |
| item_scheduled_delivery_id  | integer     | null: false                     |
| sell_price                  | integer     | null: false                     |
| user_id                     | references  | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_one :purchase

### Memo

- image(商品画像)はGem:Active Strageで実装するため、上記のカラムに含めない。
- キーと値の管理にActiveHashを利用する(item_category_id, item_status_id, item_shipping_fee_status_id, item_prefecture_id, item_scheduled_delivery_id)

## purchases テーブル(商品購入テーブル)

| Column                   | Type        | Options                         |
| ------------------------ | ----------- | ------------------------------- |
| item_id                  | references  | null: false, foreign_key: true  |
| user_id                  | references  | null: false, foreign_key: true  |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addresses テーブル(住所登録テーブル)

| Column                   | Type        | Options                         |
| ------------------------ | ----------- | ------------------------------- |
| zipcode                  | string      | null: false                     |
| prefecture_id            | integer     | null: false                     |
| city                     | string      | null: false                     |
| address                  | string      | null: false                     |
| address_building_name    | string      |                                 |
| telephone                | string      | null: false                     |
| purchase_id              | references  | null: false, foreign_key: true  |

### Association

- belongs_to :purchase

### Memo

- キーと値の管理にActiveHashを利用する(prefecture_id）