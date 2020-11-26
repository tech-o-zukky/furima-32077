class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string      :item_name,                   null: false
      t.text        :item_explanation,            null: false
      t.integer     :item_category_id,            null: false
      t.integer     :item_status_id,              null: false
      t.integer     :item_shipping_fee_status_id, null: false
      t.integer     :prefecture_id,               null: false
      t.integer     :item_scheduled_delivery_id,  null: false
      t.integer     :sell_price,                  null: false
      t.references  :user,                        null: false, foreign_key: true

      t.timestamps
    end
  end
end
